namespace ImGui
{
bool KeyboardInput(const char* label, char* buf, unsigned int buf_size, const ImVec2& size_arg, bool is_editable)
{
	ImGuiWindow* window = GetCurrentWindow();
	if (window->SkipItems) {
		return false;
	}

	ImGuiContext& g = *GImGui;
	const ImGuiIO& io = g.IO;
	const ImGuiStyle& style = g.Style;

	const ImGuiID id = window->GetID(label);
	const ImVec2 label_size = CalcTextSize(label, NULL, true);
	ImVec2 size = CalcItemSize(size_arg, CalcItemWidth(), label_size.y + style.FramePadding.y * 2.0f);
	const ImRect frame_bb(window->DC.CursorPos, window->DC.CursorPos + size);
	const ImRect total_bb(frame_bb.Min, frame_bb.Max + ImVec2(label_size.x > 0.0f ? (style.ItemInnerSpacing.x + label_size.x) : 0.0f, 0.0f));

	ImGuiWindow* draw_window = window;
	ItemSize(total_bb, style.FramePadding.y);
	if (!ItemAdd(total_bb, &id)) {
		return false;
	}

	const bool focus_requested = FocusableItemRegister(window, g.ActiveId == id, false);

	const bool hovered = IsHovered(frame_bb, id);
	if (hovered) {
		SetHoveredID(id);
		g.MouseCursor = ImGuiMouseCursor_TextInput;
	}
	const bool user_clicked = hovered && io.MouseClicked[0];

	if (focus_requested || user_clicked) {
		SetActiveID(id, window);
		FocusWindow(window);
	} else if (io.MouseClicked[0]) {
		// Release focus when we click outside
		if (g.ActiveId == id) {
			ClearActiveID();
		}
	}

	bool value_changed = false;
	if (g.ActiveId == id) {
		unsigned int bufLen = (unsigned int)strlen(buf);
		buf_size--; // Allow room for the final null char.
		
		// Although we are active we don't prevent mouse from hovering other elements unless we are interacting right now with the widget.
		// Down the line we should have a cleaner library-wide concept of Selected vs Active.
		g.ActiveIdAllowOverlap = !io.MouseDown[0];

		if (io.InputCharacters[0]) {
			if (!(io.KeyCtrl && !io.KeyAlt) && is_editable) {
				for (int n = 0; n < IM_ARRAYSIZE(io.InputCharacters) && io.InputCharacters[n]; n++) {
					if (unsigned int c = (unsigned int)io.InputCharacters[n]) {
						if (bufLen < buf_size) {
							buf[bufLen++] = (char)c;
						}
					}
				}
			}

			// Consume characters
			memset(g.IO.InputCharacters, 0, sizeof(g.IO.InputCharacters));
		}

		// Handle various key-presses
		if (is_editable) {
			if (IsKeyPressedMap(ImGuiKey_LeftArrow)) {
				if (bufLen < buf_size) {
					buf[bufLen++] = (char)1;
				}
			} else if (IsKeyPressedMap(ImGuiKey_RightArrow)) {
				if (bufLen < buf_size) {
					buf[bufLen++] = (char)4;
				}
			} else if (IsKeyPressedMap(ImGuiKey_UpArrow)) {
				// TODO: 
			} else if (IsKeyPressedMap(ImGuiKey_DownArrow)) {
				// TODO: 
			} else if (IsKeyPressedMap(ImGuiKey_Home)) {
				if (bufLen < buf_size) {
					buf[bufLen++] = (char)2;
				}
			} else if (IsKeyPressedMap(ImGuiKey_End)) {
				if (bufLen < buf_size) {
					buf[bufLen++] = (char)3;
				}
			} else if (IsKeyPressedMap(ImGuiKey_Delete)) {
				if (bufLen < buf_size) {
					buf[bufLen++] = (char)127;
				}
			} else if (IsKeyPressedMap(ImGuiKey_Backspace)) {
				if (bufLen < buf_size) {
					buf[bufLen++] = (char)8;
				}
			} else if (IsKeyPressedMap(ImGuiKey_Enter)) {
				if (bufLen < buf_size) {
					buf[bufLen++] = '\n';
				}
			} else if (IsKeyPressedMap(ImGuiKey_Tab)) {
				if (bufLen < buf_size) {
					buf[bufLen++] = '\t';
				}
			} else if (IsKeyPressedMap(ImGuiKey_Escape)) {
				if (bufLen < buf_size) {
					buf[bufLen++] = (char)27;
				}
			}

			buf[bufLen] = '\0';
		}
	}

	// Render
	const ImVec2 textSize = CalcTextSize(buf);

	RenderFrame(frame_bb.Min, frame_bb.Max, GetColorU32(ImGuiCol_FrameBg), true, style.FrameRounding);

	const ImVec4 clip_rect(frame_bb.Min.x, frame_bb.Min.y, frame_bb.Min.x + size.x, frame_bb.Min.y + size.y);
	ImVec2 render_pos = frame_bb.Min + style.FramePadding;
	const float frameInnerWidth = frame_bb.GetWidth() - style.FramePadding.x * 2.0f;
	if (textSize.x > frameInnerWidth) {
		render_pos.x = render_pos.x - (textSize.x - frameInnerWidth);
	}

	// Render text only
	draw_window->DrawList->AddText(g.Font, g.FontSize, render_pos, GetColorU32(ImGuiCol_Text), buf, NULL, 0.0f, &clip_rect);

	if (g.ActiveId == id) {
		g.InputTextState.CursorAnim += io.DeltaTime;

		// Draw blinking cursor
		bool cursor_is_visible = (g.InputTextState.CursorAnim <= 0.0f) || fmodf(g.InputTextState.CursorAnim, 1.20f) <= 0.80f;
		ImVec2 cursor_screen_pos = render_pos + textSize; // Always at the end of text
		ImRect cursor_screen_rect(cursor_screen_pos.x, cursor_screen_pos.y - g.FontSize + 0.5f, cursor_screen_pos.x + 1.0f, cursor_screen_pos.y - 1.5f);
		if (cursor_is_visible && cursor_screen_rect.Overlaps(clip_rect)) {
			draw_window->DrawList->AddLine(cursor_screen_rect.Min, cursor_screen_rect.GetBL(), GetColorU32(ImGuiCol_Text));
		}
	}

	if (label_size.x > 0) {
		RenderText(ImVec2(frame_bb.Max.x + style.ItemInnerSpacing.x, frame_bb.Min.y + style.FramePadding.y), label);
	}

    return value_changed;
}
}
