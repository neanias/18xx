# frozen_string_literal: true

require_relative '../g_1822/game'
require_relative 'meta'
require_relative 'entities'
require_relative 'map'
require_relative 'trains'

module Engine
  module Game
    module G1822CA
      class Game < G1822::Game
        include_meta(G1822CA::Meta)
        include G1822CA::Entities
        include G1822CA::Map
        include G1822CA::Trains

        DOUBLE_HEX = %w[G13 I15 AB22 AG13 AH10].freeze

        BIDDING_BOX_START_MINOR = 'M6'
        BIDDING_BOX_START_CONCESSION = 'C2'
        BIDDING_BOX_START_PRIVATE = 'P1'

        COMPANY_MTONR = nil # Remove Town; two companies instead of one here
        COMPANY_LCDR = nil # English Channel
        COMPANY_EGR = nil # Hill Discount
        COMPANY_DOUBLE_CASH = 'P7'
        COMPANY_GSWR = nil # River Discount
        COMPANY_BER = 'P12' # Advanced Tile Lay
        COMPANY_LSR = 'P21' # Extra Tile Lay
        COMPANY_10X_REVENUE = 'P8'
        COMPANY_OSTH = 'P11' # Tax Haven
        COMPANY_LUR = nil # Move Card
        COMPANY_CHPR = 'P28' # Station Swap
        COMPANY_5X_REVENUE = 'P9'
        COMPANY_HSBC = nil # Grimsby/Hull Bridge

        COMPANY_WINNIPEG_TOKEN = 'P10'

        COMPANIES_BIG_CITY_UPGRADES = %w[P14 P15 P16 P17 P18].freeze
        COMPANIES_EXTRA_TRACK_LAYS = (COMPANIES_BIG_CITY_UPGRADES + %w[P19 P20 P21]).freeze
        BIG_CITY_HEXES_TO_COMPANIES = {
          'AH8' => 'P17',
          'N16' => 'P18',
          'AC21' => 'P14',
          'AE15' => 'P15',
          'AF12' => 'P16',
        }.freeze

        PRIVATE_MAIL_CONTRACTS = %w[P22 P23].freeze
        PRIVATE_SMALL_MAIL_CONTRACTS = %w[P24 P25].freeze
        PRIVATE_PHASE_REVENUE = %w[P8 P9].freeze
        PRIVATE_REMOVE_REVENUE = %w[P1 P5 P6 P7 P14 P15 P16 P17 P18 P22 P23 P24 P25 P26 P27 P28].freeze
        PRIVATE_TRAINS = %w[P1 P2 P3 P4 P5 P6 P26 P27].freeze

        MOUNTAIN_PASS_HEXES = %w[E11 F16].freeze
        MOUNTAIN_PASS_TILES = %w[7 8 9].freeze
        MOUNTAIN_PASS_COMPANIES = %w[P19 P20].freeze
        MOUNTAIN_PASS_COMPANIES_TO_HEXES = { 'P20' => 'E11', 'P19' => 'F16' }.freeze

        TILE_UPGRADES_MUST_USE_MAX_EXITS = %i[unlabeled_cities].freeze
        TRACK_RESTRICTION = :permissive

        EXTRA_TRAIN_GRAIN = 'G'
        EXTRA_TRAINS = %w[2P P LP G].freeze
        EXTRA_TRAIN_PULLMAN = 'P'

        GRAIN_ELEVATORS = %w[G13 H16 I11 I15 I17 J16 K13 K17 L16 M17].freeze
        GRAIN_ELEVATOR_TYPE = 'grain_elevator'.freeze
        GRAIN_ELEVATOR_COUNT = 12
        WEST_PORTS = %w[A7 C15].freeze
        EAST_PORTS = %w[N6 R16].freeze

        DETROIT_TO_DULUTH_HEXES = %w[Q19 Y27].freeze

        COMPANY_SHORT_NAMES = {
          'P1' => 'P1 (5-Train)',
          'P2' => 'P2 (Permanent L-Train)',
          'P3' => 'P3 (Permanent 2-Train)',
          'P4' => 'P4 (Permanent 2-Train)',
          'P5' => 'P5 (Pullman)',
          'P6' => 'P6 (Pullman)',
          'P7' => 'P7 (Declare 2× Cash Holding)',
          'P8' => 'P8 ($10× Phase)',
          'P9' => 'P9 ($5× Phase)',
          'P10' => 'P10 (Winnipeg Station)',
          'P11' => 'P11 (Tax Haven)',
          'P12' => 'P12 (Advanced Tile Lay)',
          'P13' => 'P13 (Sawmill Bonus)',
          'P14' => 'P14 (Free Toronto Upgrades)',
          'P15' => 'P15 (Free Ottawa Upgrades)',
          'P16' => 'P16 (Free Montreal Upgrades)',
          'P17' => 'P17 (Free Quebec Upgrades)',
          'P18' => 'P18 (Free Winnipeg Upgrades)',
          'P19' => 'P19 (Crowsnest Pass Tile)',
          'P20' => 'P20 (Yellowhead Pass Tile)',
          'P21' => 'P21 (3-Tile Grant)',
          'P22' => 'P22 (Large Mail Contract)',
          'P23' => 'P23 (Large Mail Contract)',
          'P24' => 'P24 (Small Mail Contract)',
          'P25' => 'P25 (Small Mail Contract)',
          'P26' => 'P26 (Grain Train)',
          'P27' => 'P27 (Grain Train)',
          'P28' => 'P28 (Station Token Swap)',
          'P29' => 'P29 (Remove Single Town)',
          'P30' => 'P30 (Remove Single Town)',
          'C1' => 'CNoR',
          'C2' => 'CPR',
          'C3' => 'GNWR',
          'C4' => 'GT',
          'C5' => 'GTP',
          'C6' => 'GWR',
          'C7' => 'ICR',
          'C8' => 'NTR',
          'C9' => 'PGE',
          'C10' => 'QMOO',
          'M1' => '1',
          'M2' => '2',
          'M3' => '3',
          'M4' => '4',
          'M5' => '5',
          'M6' => '6',
          'M7' => '7',
          'M8' => '8',
          'M9' => '9',
          'M10' => '10',
          'M11' => '11',
          'M12' => '12',
          'M13' => '13',
          'M14' => '14',
          'M15' => '15',
          'M16' => '16',
          'M17' => '17',
          'M18' => '18',
          'M19' => '19',
          'M20' => '20',
          'M21' => '21',
          'M22' => '22',
          'M23' => '23',
          'M24' => '24',
          'M25' => '25',
          'M26' => '26',
          'M27' => '27',
          'M28' => '28',
          'M29' => '29',
          'M30' => '30',
        }.freeze

        MAJOR_TILE_LAYS = [
          { lay: true, upgrade: true, cannot_reuse_same_hex: true },
          { lay: :not_if_upgraded, upgrade: false, cannot_reuse_same_hex: true },
        ].freeze

        CURRENCY_FORMAT_STR = '$%s'
        FORMAT_UPGRADES_ON_HEXES = true

        EXCHANGE_TOKENS = {
          'CNoR' => 3,
          'CPR' => 4,
          'GNWR' => 3,
          'GT' => 3,
          'GTP' => 3,
          'GWR' => 3,
          'ICR' => 3,
          'NTR' => 3,
          'PGE' => 3,
          'QMOO' => 3,
        }.freeze

        MARKET = [
          %w[5y 10y 15y 20y 25y 30y 35y 40y 45y 50p 60xp 70xp 80xp 90xp 100xp 110 120 135 150 165 180 200 220
             245 270 300 330 360 400 450 500 550 600 650 700e],
        ].freeze

        MINOR_14_ID = '13'
        MINOR_14_HOME_HEX = 'AC21'
        PENDING_HOME_TOKENERS = [MINOR_14_ID, 'QMOO'].freeze

        MULTIPLE_TOKENS_ON_SAME_HEX_ALLOWED = true

        TWO_HOME_CORPORATION = 'CPR'

        PRIVATE_COMPANIES_ACQUISITION = {
          'P1' => { acquire: %i[major], phase: 5 },
          'P2' => { acquire: %i[major minor], phase: 1 },
          'P3' => { acquire: %i[major], phase: 2 },
          'P4' => { acquire: %i[major], phase: 2 },
          'P5' => { acquire: %i[major], phase: 5 },
          'P6' => { acquire: %i[major], phase: 5 },
          'P7' => { acquire: %i[major], phase: 3 },
          'P8' => { acquire: %i[major minor], phase: 2 },
          'P9' => { acquire: %i[major minor], phase: 2 },
          'P10' => { acquire: %i[major minor], phase: 3 },
          'P11' => { acquire: [], phase: 8 },
          'P12' => { acquire: %i[major minor], phase: 1 },
          'P13' => { acquire: %i[major minor], phase: 3 },
          'P14' => { acquire: %i[major minor], phase: 1 },
          'P15' => { acquire: %i[major minor], phase: 1 },
          'P16' => { acquire: %i[major minor], phase: 1 },
          'P17' => { acquire: %i[major minor], phase: 1 },
          'P18' => { acquire: %i[major minor], phase: 1 },
          'P19' => { acquire: %i[major minor], phase: 3 },
          'P20' => { acquire: %i[major minor], phase: 3 },
          'P21' => { acquire: %i[major minor], phase: 3 },
          'P22' => { acquire: %i[major minor], phase: 3 },
          'P23' => { acquire: %i[major minor], phase: 3 },
          'P24' => { acquire: %i[major minor], phase: 3 },
          'P25' => { acquire: %i[major minor], phase: 3 },
          'P26' => { acquire: %i[major minor], phase: 3 },
          'P27' => { acquire: %i[major minor], phase: 3 },
          'P28' => { acquire: %i[major minor], phase: 3 },
          'P29' => { acquire: %i[major minor], phase: 1 },
          'P30' => { acquire: %i[major minor], phase: 1 },
        }.freeze

        STARTING_COMPANIES = %w[P1 P2 P3 P4 P5 P6 P7 P8 P9 P10 P11 P12 P13 P14 P15 P16 P17 P18 P19 P20 P21 P22 P23
                                P24 P25 P26 P27 P28 P29 P30 C1 C2 C3 C4 C5 C6 C7 C8 C9 C10
                                M1 M2 M3 M4 M5 M6 M7 M8 M9 M10 M11 M12 M13 M14 M15 M16 16 M17 M18 M19 M20 M21 M22
                                M23 M24 M25 M26 M27 M28 M29 M30].freeze

        STARTING_CORPORATIONS = %w[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
                                   CNoR CPR GNWR GT GTP GWR ICR NTR PGE QMOO].freeze

        TAX_HAVEN_MULTIPLE = true

        MUST_SELL_IN_BLOCKS = true

        EVENTS_TEXT = G1822::Game::EVENTS_TEXT.merge(
          'open_detroit_duluth' => ['Open Detroit-Duluth',
                                    'Phase 3: the connection between Detroit (Y29) and Duluth (P18) opens'],
        )

        STATUS_TEXT = G1822::Game::STATUS_TEXT.merge(
          'l_upgrade' => ['$70 L-train upgrades',
                          'The cost to upgrade an L-train to a 2-train is reduced from $80 to $70.']
        )

        # the big city tiles have complex arrangements of multiple cities and
        # multiple possible upgrade paths, the implemented upgrade logic can't
        # handle all of them so some restrictions are hardcoded here instead of
        # writing logic that wouldn't be very common
        BIG_CITY_ILLEGAL_TILE_UPGRADES = {
          'M2' => 'M6',
          'M3' => 'M4',
          'O2' => 'O3',
          'O4' => 'O5',
          'Q4' => 'Q5',
          'T5' => 'T6',
          'W5' => 'W6',
        }.freeze

        attr_accessor :sawmill_hex, :sawmill_owner, :train_with_grain, :train_with_pullman
        attr_writer :sawmill_bonus

        def setup_game_specific
          # Initialize the stock round choice for P7-Double Cash
          @double_cash_choice = nil

          # Initialize a dummy player for Tax haven to hold the share and the cash it generates
          @tax_haven = Engine::Player.new(-1, 'Tax Haven')

          # Initialize the extra city which minor 14 (actually 13 in 22CA) might add
          @minor_14_city_exit = nil

          # P13 Sawmill Bonus
          @sawmill_bonus = 0
          @sawmill_hex = nil
          @sawmill_owner = nil

          block_detroit_duluth
        end

        # setup_companies from 1822 has too much 1822-specific stuff that doesn't apply to this game
        def setup_companies
          # Randomize from preset seed to get same order
          @companies.sort_by! { rand }

          minors = @companies.select { |c| c.id[0] == self.class::COMPANY_MINOR_PREFIX }
          concessions = @companies.select { |c| c.id[0] == self.class::COMPANY_CONCESSION_PREFIX }
          privates = @companies.select { |c| c.id[0] == self.class::COMPANY_PRIVATE_PREFIX }

          if bidbox_start_minor
            m6 = minors.find { |c| c.id == bidbox_start_minor }
            minors.delete(m6)
            minors.unshift(m6)
          end

          c2 = concessions.find { |c| c.id == bidbox_start_concession }
          concessions.delete(c2)
          concessions.unshift(c2)

          p1 = privates.find { |c| c.id == bidbox_start_private }
          privates.delete(p1)
          privates.unshift(p1)

          # Clear and add the companies in the correct randomize order sorted by type
          @companies.clear
          @companies.concat(minors)
          @companies.concat(concessions)
          @companies.concat(privates)

          # Set the min bid on the Concessions and Minors
          @companies.each do |c|
            c.min_price = case c.id[0]
                          when self.class::COMPANY_CONCESSION_PREFIX, self.class::COMPANY_MINOR_PREFIX
                            c.value
                          else
                            0
                          end
            c.max_price = 10_000
          end

          # Setup company abilities
          @company_trains = {}
          @company_trains['P3'] = find_and_remove_train_by_id('2P-0', buyable: false)
          @company_trains['P4'] = find_and_remove_train_by_id('2P-1', buyable: false)
          @company_trains['P1'] = find_and_remove_train_by_id('5P-0')
          @company_trains['P1'].name = '5'
          @company_trains['P5'] = find_and_remove_train_by_id('P-0', buyable: false)
          @company_trains['P6'] = find_and_remove_train_by_id('P-1', buyable: false)
          @company_trains['P2'] = find_and_remove_train_by_id('LP-0', buyable: false)
          @company_trains['P26'] = find_and_remove_train_by_id('G-0', buyable: false)
          @company_trains['P27'] = find_and_remove_train_by_id('G-1', buyable: false)
        end

        def operating_round(round_num)
          Engine::Round::Operating.new(self, [
            G1822CA::Step::PendingToken,
            G1822::Step::FirstTurnHousekeeping,
            Engine::Step::AcquireCompany,
            G1822CA::Step::DiscardTrain,
            G1822CA::Step::AssignSawmill,
            G1822::Step::SpecialChoose,
            G1822CA::Step::SpecialTrack,
            G1822CA::Step::SpecialToken,
            G1822CA::Step::Track,
            G1822CA::Step::DestinationToken,
            G1822CA::Step::Token,
            G1822CA::Step::Route,
            G1822::Step::Dividend,
            G1822::Step::BuyTrain,
            G1822CA::Step::MinorAcquisition,
            G1822CA::Step::AcquisitionTrack,
            G1822CA::Step::PendingToken,
            G1822CA::Step::DiscardTrain,
            G1822CA::Step::IssueShares,
          ], round_num: round_num)
        end

        def must_remove_town?(entity)
          %w[P29 P30].include?(entity.id)
        end

        def upgrades_to?(from, to, _special = false, selected_company: nil)
          return %w[5 6 57].include?(to.name) if from.name == 'AG13' && from.color == :white
          return false if self.class::BIG_CITY_ILLEGAL_TILE_UPGRADES[from.name] == to.name

          super
        end

        def company_ability_extra_track?(company)
          self.class::COMPANIES_EXTRA_TRACK_LAYS.include?(company.id)
        end

        def sell_movement
          @sell_movement ||= @players.size == 2 ? :left_share_pres : :left_per_10_if_pres_else_left_one
        end

        def routes_subsidy(routes)
          super + small_mail_contract_subsidy(routes)
        end

        def upgrades_to_correct_label?(from, to)
          super || (MOUNTAIN_PASS_HEXES.include?(from.hex&.id) && MOUNTAIN_PASS_TILES.include?(to.name))
        end

        def small_mail_contract_subsidy(routes)
          return 0 if routes.empty?

          entity = routes.first.train.owner
          contract_count = entity.companies.count { |c| self.class::PRIVATE_SMALL_MAIL_CONTRACTS.include?(c.id) }
          contract_count *
            case @phase.name.to_i
            when (3..4)
              20
            when (5..6)
              30
            when 7
              40
            else
              0
            end
        end

        def revenue_for(route, stops)
          revenue = super

          sawmill_bonus = sawmill_bonus(route.routes)
          revenue += sawmill_bonus[:revenue] if sawmill_bonus && sawmill_bonus[:route] == route

          revenue += grain_and_port_bonus(route.train, stops)[:revenue]

          revenue
        end

        def revenue_str(route)
          str = super

          sawmill_bonus = sawmill_bonus(route.routes)
          str += " + Sawmill ($#{sawmill_bonus[:revenue]})" if sawmill_bonus && sawmill_bonus[:route] == route

          str += grain_and_port_bonus(route.train, route.stops)[:description]

          str
        end

        def sawmill_bonus(routes)
          return if routes.empty?
          return unless @sawmill_hex
          return unless receives_sawmill_bonus?(routes[0].train.owner)

          sawmill_bonuses = routes.map { |r| calculate_sawmill_bonus(r) }.compact
          sawmill_bonuses.sort_by { |v| v[:revenue] }.reverse&.first
        end

        def calculate_sawmill_bonus(route)
          return unless (sawmill_stop = route.visited_stops.find { |s| s.hex == @sawmill_hex })

          entity = route.train.owner
          sawmill_dest = sawmill_stop.city? &&
                         sawmill_stop.tokens.find { |t| t && t.type == :destination && t.corporation == entity } &&
                         (dest = destination_bonus(route.routes)) &&
                         dest[:route] == route
          multiplier = sawmill_dest ? 2 : 1

          { route: route, revenue: @sawmill_bonus * multiplier }
        end

        def receives_sawmill_bonus?(entity)
          return false if entity.type != :major
          return @sawmill_owner == entity if @sawmill_owner

          true
        end

        def assignment_tokens(assignment, _simple_logos = false)
          return unless assignment == 'P13'

          token_type = @sawmill_owner ? 'closed' : 'open'
          "/icons/1822_ca/sawmill_#{token_type}.svg"
        end

        def game_end_check
          @game_end_reason ||=
            begin
              reason = compute_game_end
              @operating_rounds += 1 if reason == %i[bank full_or]
              reason
            end
        end

        def grain_train?(train)
          train.name == self.class::EXTRA_TRAIN_GRAIN
        end

        def grain_train_count(corporation)
          corporation.trains.count { |train| grain_train?(train) }
        end

        def crowded_corp?(corp)
          crowded = super
          crowded |= grain_train_count(corp) > 1
          crowded
        end

        def remove_discarded_train?(train)
          super || grain_train?(train)
        end

        def route_trains(entity)
          super.reject { |t| grain_train?(t) }
        end

        def check_distance(route, visits, train = nil)
          raise GameError, 'Cannot run Grain train' if grain_train?(train || route.train)

          super
        end

        def stop_type(stop, train)
          return super unless train == @train_with_grain

          if GRAIN_ELEVATORS.include?(stop.hex.id)
            GRAIN_ELEVATOR_TYPE
          else
            stop.type
          end
        end

        def grain_and_port_bonus(train, stops)
          no_bonus = { revenue: 0, description: '' }
          return no_bonus if train.owner.type == :minor
          return no_bonus if train == @train_with_pullman || train.name == self.class::E_TRAIN

          grain_elevators = 0
          east_ports = 0
          west_ports = 0
          stops.each do |stop|
            grain_elevators += 1 if GRAIN_ELEVATORS.include?(stop.hex.id)
            east_ports |= 1 if EAST_PORTS.include?(stop.hex.id)
            west_ports |= 1 if WEST_PORTS.include?(stop.hex.id)
          end

          return no_bonus unless grain_elevators.positive?

          ports = east_ports + west_ports

          description = ''
          if train == @train_with_grain
            port_bonus = 20 * ports
            description += " + Port#{ports == 1 ? '' : 's'} ($#{port_bonus})" if port_bonus.positive?
            { revenue: port_bonus, description: description }
          else
            grain_bonus = 10 * grain_elevators
            description += " + Grain ($#{grain_bonus})"

            port_bonus = 10 * ports
            description += " + Port#{ports == 1 ? '' : 's'} ($#{port_bonus})" if port_bonus.positive?

            { revenue: grain_bonus + port_bonus, description: description }
          end
        end

        def route_distance_str(route)
          train = route.train
          return super unless [@train_with_pullman, @train_with_grain].include?(train)

          counts = route.visited_stops.each_with_object(Hash.new(0)) do |stop, c|
            c[stop_type(stop, train)] += 1
          end

          case train
          when @train_with_pullman
            towns = counts['town']
            cities = counts['city'] + counts['offboard']
            towns.positive? ? "#{cities}+#{towns}" : cities.to_s
          when @train_with_grain
            grain_elevators = counts['grain_elevator']
            return cities.to_s unless grain_elevators.positive?

            if train.name[0] == 'L'
              cities = counts['city'] + counts['offboard']
              towns = counts['town']
              towns.positive? ? "#{cities}+#{towns}+#{grain_elevators}G" : "#{cities}+#{grain_elevators}G"
            else
              cities = counts['city'] + counts['offboard'] + counts['town']
              "#{cities}+#{grain_elevators}G"
            end
          else
            ''
          end
        end

        def block_detroit_duluth
          corp = @detroit_duluth_blocker = Corporation.new(
            sym: 'DD',
            name: 'Detroit-Duluth blocker',
            logo: '1822_ca/no_yellow',
            simple_logo: '1822_ca/no_yellow',
            tokens: [0, 0],
          )
          corp.owner = @bank
          DETROIT_TO_DULUTH_HEXES.each do |hex_id|
            hex_by_id(hex_id).tile.cities[0].place_token(corp, corp.next_token)
          end
        end

        def event_open_detroit_duluth!
          @log << '-- Event: the southern route connecting Detroit (Y29) and Duluth (P18) is now open --'

          @detroit_duluth_blocker.tokens.compact.each(&:destroy!)
          @detroit_duluth_blocker.close!

          DETROIT_TO_DULUTH_HEXES.each do |hex_id|
            hex = hex_by_id(hex_id)
            tile = tile_by_id("DD-#{hex_id}-0")
            hex.lay(tile)
          end
          @graph.clear
        end

        # - usually returns a single city
        # - returns an Array of cities if entity is ICR and Quebec has multiple
        #   cities with paths
        def destination_city(hex, entity)
          return hex.tile.cities[0] unless (exits = entity.destination_exits)

          dest_cities = exits.each_with_object([]) do |exit, cities|
            hex.paths[exit].each do |path|
              next unless (city = path.city)

              cities << city unless cities.include?(city)
            end
          end
          dest_cities.one? ? dest_cities[0] : dest_cities
        end

        def destination_description(corporation)
          return super unless (exits = corporation.destination_exits)

          dest_hex = hex_by_id(corporation.destination_coordinates)
          which =
            if exits.size == 6
              'Any '
            elsif exits.one?
              %w[S SW NW N NE SE][exits[0]] + ' '
            else
              ''
            end
          "Destination: #{which}#{dest_hex.location_name} (#{dest_hex.name})"
        end

        def price_movement_chart
          non_director_sales =
            (['One or more shares sold (if sold by non-director)', '1 ←'] if sell_movement == :left_per_10_if_pres_else_left_one)

          [
            ['Action', 'Share Price Change'],
            ['Dividend 0 or withheld', '1 ←'],
            ['Dividend < share price', 'none'],
            ['Dividend ≥ share price, < 2x share price ', '1 →'],
            ['Dividend ≥ 2x share price', '2 →'],
            ['Minor company dividend > 0', '1 →'],
            ['Each share sold (if sold by director)', '1 ←'],
            non_director_sales,
            ['Corporation sold out at end of SR', '1 →'],
          ].compact
        end

        def action_processed(action)
          case action
          when Action::LayTile
            if action.tile.color == :gray && (id = BIG_CITY_HEXES_TO_COMPANIES[action.hex.id])
              company_by_id(id)&.all_abilities&.clear
            end
          end
        end
      end
    end
  end
end
