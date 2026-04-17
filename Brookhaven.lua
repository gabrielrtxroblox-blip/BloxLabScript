-- [[ BLOX LAB | NEXUS SUPREMACY V4 ]] --
-- [[ DESENVOLVEDOR: GABRIELRTXROBLOXRTX ]] --

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "💜 BLOX LAB | SUPREMACIA V4 💜",
   LoadingTitle = "ESTABELECENDO CONEXÃO NEXUS...",
   LoadingSubtitle = "by Fabricio (GabrielrtxrobloxRtx)",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "BloxLabData",
      FileName = "BrookhavenPro"
   },
   KeySystem = false, -- Sistema sem chave para facilitar o acesso
   Theme = "DarkBlue"
})

-- [[ VARIÁVEIS DE CONTROLE ]] --
local lp = game.Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

-- [[ ABA 01: JOGADOR (PLAYER) ]] --
local TabPlayer = Window:CreateTab("Jogador", 4483362458)

TabPlayer:CreateSlider({
   Name = "Velocidade (WalkSpeed)",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      lp.Character.Humanoid.WalkSpeed = Value
   end,
})

TabPlayer:CreateSlider({
   Name = "Poder do Pulo (JumpPower)",
   Range = {50, 600},
   Increment = 1,
   CurrentValue = 50,
   Callback = function(Value)
      lp.Character.Humanoid.JumpPower = Value
   end,
})

TabPlayer:CreateToggle({
   Name = "Pulo Infinito",
   CurrentValue = false,
   Callback = function(Value)
      _G.InfiniteJump = Value
      game:GetService("UserInputService").JumpRequest:Connect(function()
         if _G.InfiniteJump then
            lp.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
         end
      end)
   end,
})

-- [[ ABA 02: TELEPORTES (LOCAIS & SEGREDOS) ]] --
local TabTP = Window:CreateTab("Teleportes", 4483362458)

local Locais = {
   ["Cofre do Banco"] = Vector3.new(-439, 23, -135),
   ["Delegacia (Prisão)"] = Vector3.new(-338, 23, -161),
   ["Hospital (Passagem)"] = Vector3.new(-473, 23, -182),
   ["Lago (Spawn)"] = Vector3.new(-120, 23, 500),
   ["Painel Solar Secreto"] = Vector3.new(-548, 70, -112),
   ["Base dos Criminosos"] = Vector3.new(-65, 23, -290)
}

for Nome, Pos in pairs(Locais) do
   TabTP:CreateButton({
      Name = "Teleportar: " .. Nome,
      Callback = function()
         lp.Character.HumanoidRootPart.CFrame = CFrame.new(Pos)
      end,
   })
end

-- [[ ABA 03: VISUAIS & ESP ]] --
local TabVisual = Window:CreateTab("Visual/ESP", 4483362458)

TabVisual:CreateButton({
   Name = "Ativar Nome dos Jogadores (ESP)",
   Callback = function()
      for _, v in pairs(game.Players:GetPlayers()) do
         if v ~= lp and v.Character and v.Character:FindFirstChild("Head") then
            local Billboard = Instance.new("BillboardGui", v.Character.Head)
            Billboard.Size = UDim2.new(0, 150, 0, 50)
            Billboard.AlwaysOnTop = true
            local Text = Instance.new("TextLabel", Billboard)
            Text.Text = v.Name
            Text.Size = UDim2.new(1, 0, 1, 0)
            Text.BackgroundTransparency = 1
            Text.TextColor3 = Color3.fromRGB(138, 43, 226) -- Roxo Nexus
            Text.TextScaled = true
         end
      end
   end,
})

TabVisual:CreateButton({
   Name = "Iluminação Total (FullBright)",
   Callback = function()
      local L = game:GetService("Lighting")
      L.Brightness = 2
      L.ClockTime = 14
      L.GlobalShadows = false
   end,
})

-- [[ ABA 04: TROLL & COMBATE ]] --
local TabTroll = Window:CreateTab("Troll", 4483362458)

TabTroll:CreateButton({
   Name = "Fling (Girar e Expulsar)",
   Callback = function()
      local Rot = Instance.new("BodyAngularVelocity", lp.Character.HumanoidRootPart)
      Rot.AngularVelocity = Vector3.new(0, 99999, 0)
      Rot.MaxTorque = Vector3.new(0, 99999, 0)
      Rayfield:Notify({Title = "Troll Ativado", Content = "Encoste em alguém para lançar!", Duration = 5})
      task.wait(8)
      Rot:Destroy()
   end,
})

TabTroll:CreateButton({
   Name = "Resetar Personagem",
   Callback = function()
      lp.Character.Humanoid.Health = 0
   end,
})

-- [[ SISTEMA ANTI-AFK & BYPASS ]] --
local function Init()
    -- Impede de cair da partida por ficar parado
    local VU = game:GetService("VirtualUser")
    lp.Idled:Connect(function()
        VU:CaptureController()
        VU:ClickButton2(Vector2.new())
    end)
    
    Rayfield:Notify({
       Title = "NEXUS ONLINE",
       Content = "Bem-vindo, Fabricio! Tudo pronto para dominar.",
       Duration = 5,
       Image = 4483362458,
    })
end

Init()
