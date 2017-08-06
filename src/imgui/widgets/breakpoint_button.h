namespace ImGui 
{
// This is the same as ImGui::RadioButton() but without a label and slightly different styling
inline bool BreakpointButton(ImGuiID btnID, bool active)
{
	ImGuiWindow* window = GetCurrentWindow();
	if (window->SkipItems)
		return false;

	char title[256];
	ImFormatString(title, IM_ARRAYSIZE(title), "%s.%08X", window->Name, btnID);
	const ImGuiID id = window->GetID(title);

	ImGuiContext& g = *GImGui;
	const ImGuiStyle& style = g.Style;

	const ImVec2 label_size(0.0f, 8.0f);

	const ImRect check_bb(window->DC.CursorPos, window->DC.CursorPos + ImVec2(label_size.y + style.FramePadding.y * 2 - 1, label_size.y + style.FramePadding.y * 2 - 1));
	ItemSize(check_bb, style.FramePadding.y);

	ImRect total_bb = check_bb;
	if (label_size.x > 0)
		SameLine(0, style.ItemInnerSpacing.x);
	const ImRect text_bb(window->DC.CursorPos + ImVec2(0, style.FramePadding.y), window->DC.CursorPos + ImVec2(0, style.FramePadding.y) + label_size);
	if (label_size.x > 0) {
		ItemSize(ImVec2(text_bb.GetWidth(), check_bb.GetHeight()), style.FramePadding.y);
		total_bb.Add(text_bb);
	}

	if (!ItemAdd(total_bb, &id))
		return false;

	ImVec2 center = check_bb.GetCenter();
	center.x = (float)(int)center.x + 0.5f;
	center.y = (float)(int)center.y + 0.5f;
	const float radius = check_bb.GetHeight() * 0.5f;

	bool hovered, held;
	bool pressed = ButtonBehavior(total_bb, id, &hovered, &held);

	if (held || hovered) {
		window->DrawList->AddCircleFilled(center, radius, GetColorU32((held && hovered) ? ImGuiCol_FrameBgActive : hovered ? ImGuiCol_FrameBgHovered : ImGuiCol_FrameBg), 16);
	}

	if (active) {
		const float check_sz = ImMin(check_bb.GetWidth(), check_bb.GetHeight());
		const float pad = ImMax(1.0f, (float)(int)(check_sz / 6.0f));
		window->DrawList->AddCircleFilled(center, radius - pad, GetColorU32(ImGuiCol_CheckMark), 16);
	}

//	if (window->Flags & ImGuiWindowFlags_ShowBorders) {
//		window->DrawList->AddCircle(center + ImVec2(1, 1), radius, GetColorU32(ImGuiCol_BorderShadow), 16);
//		window->DrawList->AddCircle(center, radius, GetColorU32(ImGuiCol_Border), 16);
//	}

	return pressed;
}
}
