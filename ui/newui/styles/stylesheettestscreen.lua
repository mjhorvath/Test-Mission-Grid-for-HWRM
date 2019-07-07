StyleSheetTestScreen = 
{
	size =  {0,0,800,600,},
	stylesheet = "HW2StyleSheet",
	RootElementSettings = 
	{
		backgroundColor = {0,0,0,255,},
	},
	;
	{
		type = "Frame",
		position = {4,4,},
		size = {792,592,},
		outerBorderWidth = 2,
		borderColor = "FEColorOutline",
		backgroundColor = "IGColorBackground1",
		autoarrange = 1,
		autoarrangeSpace = 5,
		;
		-- Heading text styles
		{
			type = "TextLabel",
			size = {700,20,},
			outerBorderWidth = 1,
			borderColor = "IGColorOutline",
			Text = 
			{
				text = "FEHeading1",
				textStyle = "FEHeading1",
			},
		},
		{
			type = "TextLabel",
			size = {700,20,},
			outerBorderWidth = 1,
			borderColor = "IGColorOutline",
			Text = 
			{
				text = "FEHeading2",
				textStyle = "FEHeading2",
			},
		},
		{
			type = "TextLabel",
			size = {700,20,},
			outerBorderWidth = 1,
			borderColor = "IGColorOutline",
			Text = 
			{
				text = "FEHeading3",
				textStyle = "FEHeading3",
			},
		},
		{
			type = "TextLabel",
			size = {700,20,},
			outerBorderWidth = 1,
			borderColor = "IGColorOutline",
			Text = 
			{
				text = "FEHeading4//",
				textStyle = "FEHeading4",
			},
		},
		-- Button Styles
		{
			type = "TextButton",
			buttonStyle = "FEButtonStyle1",
			size = {100,20,},
			Text = 
			{
				text = "FEButtonStyle1",
				textStyle = "FEButtonTextStyle",
			},
			enabled = 1,
			pressed = 0,
			onMouseClicked = "UI_ShowScreen(\"NewMainMenu\", eTransition);",
		},
		{
			type = "TextButton",
			buttonStyle = "FEButtonStyle1",
			size = {100,20,},
			Text = 
			{
				text = "FEButtonStyle1",
				textStyle = "FEButtonTextStyle",
			},
			enabled = 0,
			pressed = 0,
		},
		{
			type = "TextButton",
			buttonStyle = "FEButtonStyle1",
			size = {100,20,},
			Text = 
			{
				text = "FEButtonStyle1",
				textStyle = "FEButtonTextStyle",
			},
			enabled = 1,
			pressed = 1,
			onMouseClicked = "UI_ShowScreen(\"NewMainMenu\", eTransition);",
		},
		{
			type = "TextButton",
			buttonStyle = "FEButtonStyle2",
			size = {100,20,},
			Text = 
			{
				text = "FEButtonStyle2",
				textStyle = "FEButtonTextStyle",
			},
			enabled = 1,
			pressed = 0,
			onMouseClicked = "UI_ReloadScreen(\"StyleSheetTestScreen\");",
		},
		{
			type = "TextButton",
			buttonStyle = "FEButtonStyle2",
			size = {100,20,},
			Text = 
			{
				text = "FEButtonStyle2",
				textStyle = "FEButtonTextStyle",
			},
			enabled = 0,
			pressed = 0,
		},
		{
			type = "TextButton",
			buttonStyle = "FEButtonStyle2",
			size = {100,20,},
			Text = 
			{
				text = "FEButtonStyle2",
				textStyle = "FEButtonTextStyle",
			},
			enabled = 1,
			pressed = 1,
		},
		{
			type = "TextButton",
			buttonStyle = "FECheckBoxButtonStyle",
			size = {10,10,},
			pressed = 0,
			enabled = 1,
		},
		{
			type = "TextButton",
			buttonStyle = "FECheckBoxButtonStyle",
			size = {10,10,},
			pressed = 1,
			enabled = 1,
		},
		{
			type = "TextButton",
			buttonStyle = "FECheckBoxButtonStyle",
			size = {10,10,},
			pressed = 0,
			enabled = 0,
		},
		-- Other styles
		{
			type = "DropDownListBox",
			dropDownListBoxStyle = "FEDropDownListBoxStyle",
--			width = 100,
			size = {100,20,},
			ListBox = 
			{
--				width = 100,
				size = {100,20,},
				backgroundColor = {0,0,0,255,},
				listBoxStyle = "FEListBoxStyle",
				selected = 0,
				;
				{
					type = "TextListBoxItem",
					buttonStyle = "FEListBoxItemButtonStyle",
					resizeToListBox = 1,
					Text = 
					{
						text = "ListBoxItem1",
						textStyle = "FEListBoxItemTextStyle",
					},
				},
				{
					type = "TextListBoxItem",
					buttonStyle = "FEListBoxItemButtonStyle",
					resizeToListBox = 1,
					Text = 
					{
						text = "ListBoxItem2",
						textStyle = "FEListBoxItemTextStyle",
					},
				},
				{
					type = "TextListBoxItem",
					buttonStyle = "FEListBoxItemButtonStyle",
					resizeToListBox = 1,
					Text = 
					{
						text = "ListBoxItem3",
						textStyle = "FEListBoxItemTextStyle",
					},
				},
				{
					type = "TextListBoxItem",
					buttonStyle = "FEListBoxItemButtonStyle",
					resizeToListBox = 1,
					Text = 
					{
						text = "ListBoxItem4",
						textStyle = "FEListBoxItemTextStyle",
					},
				},
				{
					type = "TextListBoxItem",
					buttonStyle = "FEListBoxItemButtonStyle",
					resizeToListBox = 1,
					Text = 
					{
						text = "ListBoxItem5",
						textStyle = "FEListBoxItemTextStyle",
					},
				},
			},
		},
		{
			type = "DropDownListBox",
			dropDownListBoxStyle = "FEDropDownListBoxStyle",
--			width = 100,
			size = {100,20,},
			enabled = 0,
			ListBox = 
			{
--				width = 100,
				size = {100,20,},
				backgroundColor = {0,0,0,255,},
				listBoxStyle = "FEListBoxStyle",
				selected = 0,
				;
				{
					type = "TextListBoxItem",
					buttonStyle = "FEListBoxItemButtonStyle",
					resizeToListBox = 1,
					Text = 
					{
						text = "Disabled",
						textStyle = "FEListBoxItemTextStyle",
					},
				},
			},
		},
		{
			type = "ListBox",
			size = {500,60,},
			listBoxStyle = "FEListBoxStyle_Bordered",
			selected = 0,
			arrangedir = -1,	-- does not work
			;
			{
				type = "TextListBoxItem",
				buttonStyle = "FEListBoxItemButtonStyle",
				resizeToListBox = 1,
				arrangedir = -1,	-- does not work
				Text = 
				{
					text = "ListBoxItem1",
					textStyle = "FEListBoxItemTextStyle",
				},
			},
			{
				type = "TextListBoxItem",
				buttonStyle = "FEListBoxItemButtonStyle",
				resizeToListBox = 1,
				arrangedir = -1,	-- does not work
				Text = 
				{
					text = "ListBoxItem2",
					textStyle = "FEListBoxItemTextStyle",
				},
			},
			{
				type = "TextListBoxItem",
				buttonStyle = "FEListBoxItemButtonStyle",
				resizeToListBox = 1,
				arrangedir = -1,	-- does not work
				Text = 
				{
					text = "ListBoxItem3",
					textStyle = "FEListBoxItemTextStyle",
				},
			},
			{
				type = "TextListBoxItem",
				buttonStyle = "FEListBoxItemButtonStyle",
				resizeToListBox = 1,
				arrangedir = -1,	-- does not work
				Text = 
				{
					text = "ListBoxItem4",
					textStyle = "FEListBoxItemTextStyle",
				},
			},
			{
				type = "TextListBoxItem",
				buttonStyle = "FEListBoxItemButtonStyle",
				resizeToListBox = 1,
				arrangedir = -1,	-- does not work
				Text = 
				{
					text = "ListBoxItem5",
					textStyle = "FEListBoxItemTextStyle",
				},
			},
		},
		{
			type = "TextLabel",
			style = "FESliderLabelStyle",
			name = "booyatextlabel",
			size = {500,60,},
			--wrapping = 1,
			Text = 
			{
				text = "Here is some fake text meant to represent something that was said earlier. This is a really long text so it should wrap. The color of the text has been changed, too. Ideally this container should scroll. Here is some fake text meant to represent something that was said earlier. This is a really long text so it should wrap. The color of the text has been changed, too. Ideally this container should scroll.",
				textStyle = "FEButtonTextStyle",
				color = {255,215,0,255,},
				hAlign = "Left",
				vAlign = "Top",
			},
			onScroll = [[print("txt = " .. %spos)]],
		},
		{
			type = "ScrollBar",
			scrollBarStyle = "FESliderStyle",
			sliderTextLabel = "booyatextlabel",
			size = {500,10,},
			onScroll = [[print("bar = " .. %spos)]],
		},
	},
}
