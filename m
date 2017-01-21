From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] fsck.f2fs: support -p without argument
Date: Sat, 21 Jan 2017 13:54:09 +0800
Message-ID: <20170121055409.GA47079@jaegeuk.local>
References: <20170119030341.12636-1-shengyong1@huawei.com>
	<20170119030341.12636-2-shengyong1@huawei.com>
	<20170119231926.GA42028@jaegeuk.local>
	<5881C8FF.5080909@huawei.com>
	<20170120094703.GA43432@jaegeuk.local>
	<5881FDF7.1060701@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cUodE-0001wA-N9
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 21 Jan 2017 05:54:32 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cUodC-0004FY-0y
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 21 Jan 2017 05:54:32 +0000
Content-Disposition: inline
In-Reply-To: <5881FDF7.1060701@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sheng Yong <shengyong1@huawei.com>
Cc: k@vodka.home.kg, piotr.karbowski@gmail.com, linux-f2fs-devel@lists.sourceforge.net

On 01/20, Sheng Yong wrote:
> Hi Jaegeuk,
> 
> On 1/20/2017 5:47 PM, Jaegeuk Kim wrote:
> > On 01/20, Sheng Yong wrote:
> [..]
> >>>  
> >>>  	if (!strcmp("fsck.f2fs", prog)) {
> >>> -		const char *option_string = "ad:fp:t";
> >>> +		const char *option_string = ":a:d:f:p:t:";
> >> I think there is no need to modify options -a/-f/-t, and option_string = ":ad:fp:t"
> >> is enough to fix this.
> > 
> > The reason of these messy things was to detect arguments of -a/-f/-t.
> > When I tested this in my ubnutu machine without this, fsck.f2fs would allow
> > -a with an argument like -a 1.
> > 
> [...]
> >> So we could keep these handlings of a/f/t/d as the original ones. And check
> >> if argc > optind to detect if there are unhandled unknown options left at
> >> last.
> > 
> > That will be handled by default case below?
> 
> But the argument of any option cannot be caught by default. I think this maybe
> why you did not get error message when you try -a 1.
> 
> I also test the following modification:

I've resolved the conflict of device_name in f2fs-tools/dev-test, and tested the
below change. It seems it works correctly. :)
Let me merge this first.

Thanks,

> 
> >From e2647f5815718fad57940ae6a1f9536862d99cb1 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Fri, 20 Jan 2017 17:54:51 +0800
> Subject: [PATCH] fsck.f2fs: support -p without argument
> 
> This patch allows fsck run -p without argument. So we could use -p as
> -p, -p 0, -p 1. '-p' and '-p 0' have the same meaning as '-a'. '-p 1'
> check more meta data than '-a'.
> 
> Reported-by: KARBOWSKI Piotr <piotr.karbowski@gmail.com>
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fsck/main.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 80 insertions(+), 19 deletions(-)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index 64537cc..e7282e8 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -17,6 +17,7 @@
>   */
>  #include "fsck.h"
>  #include <libgen.h>
> +#include <ctype.h>
> 
>  struct f2fs_fsck gfsck;
> 
> @@ -77,13 +78,54 @@ void sload_usage()
>  	exit(1);
>  }
> 
> +static void __handle_fsck_args(int optopt)
> +{
> +	switch (optopt) {
> +	case 'p':
> +		MSG(0, "Info: Use default preen mode\n");
> +		c.preen_mode = PREEN_MODE_0;
> +		c.auto_fix = 1;
> +		break;
> +	default:
> +		MSG(0, "\tError: Need argument for -%c\n", optopt);
> +		fsck_usage();
> +	}
> +}
> +
> +static int is_digits(char *optarg)
> +{
> +	int i;
> +
> +	for (i = 0; i < strlen(optarg); i++)
> +		if (!isdigit(optarg[i]))
> +			break;
> +	return i == strlen(optarg);
> +}
> +
>  void f2fs_parse_options(int argc, char *argv[])
>  {
>  	int option = 0;
>  	char *prog = basename(argv[0]);
> +	int err = 0;
> +
> +	if (argc < 2) {
> +		MSG(0, "\tError: Device not specified\n");
> +		if (c.func == FSCK)
> +			fsck_usage();
> +		else if (c.func == DUMP)
> +			dump_usage();
> +		else if (c.func == DEFRAG)
> +			defrag_usage();
> +		else if (c.func == RESIZE)
> +			resize_usage();
> +		else if (c.func == SLOAD)
> +			sload_usage();
> +	}
> +	c.device_name = strdup(argv[argc - 1]);
> +	argv[argc-- - 1] = 0;
> 
>  	if (!strcmp("fsck.f2fs", prog)) {
> -		const char *option_string = "ad:fp:t";
> +		const char *option_string = ":ad:fp:t";
> 
>  		c.func = FSCK;
>  		while ((option = getopt(argc, argv, option_string)) != EOF) {
> @@ -97,6 +139,16 @@ void f2fs_parse_options(int argc, char *argv[])
>  				 *  0: default level, the same as -a
>  				 *  1: check meta
>  				 */
> +				if (optarg[0] == '-') {
> +					c.preen_mode = PREEN_MODE_0;
> +					optind--;
> +					break;
> +				} else if (!is_digits(optarg)) {
> +					MSG(0, "\tError: Wrong option -%c %s\n",
> +							option, optarg);
> +					err = 1;
> +					break;
> +				}
>  				c.preen_mode = atoi(optarg);
>  				if (c.preen_mode < 0)
>  					c.preen_mode = PREEN_MODE_0;
> @@ -108,9 +160,19 @@ void f2fs_parse_options(int argc, char *argv[])
>  					"preen mode %d\n", c.preen_mode);
>  				break;
>  			case 'd':
> +				if (optarg[0] == '-') {
> +					MSG(0, "\tError: Need argument for -%c\n",
> +							option);
> +					err = 1;
> +					break;
> +				} else if (!is_digits(optarg)) {
> +					MSG(0, "\tError: Wrong option -%c %s\n",
> +							option, optarg);
> +					err = 1;
> +					break;
> +				}
>  				c.dbg_lv = atoi(optarg);
> -				MSG(0, "Info: Debug level = %d\n",
> -							c.dbg_lv);
> +				MSG(0, "Info: Debug level = %d\n", c.dbg_lv);
>  				break;
>  			case 'f':
>  				c.fix_on = 1;
> @@ -119,11 +181,25 @@ void f2fs_parse_options(int argc, char *argv[])
>  			case 't':
>  				c.dbg_lv = -1;
>  				break;
> +			case ':':
> +				__handle_fsck_args(optopt);
> +				break;
> +			case '?':
> +				MSG(0, "\tError: Unknown option %c\n", optopt);
> +				err = 1;
> +				break;
>  			default:
>  				MSG(0, "\tError: Unknown option %c\n", option);
> -				fsck_usage();
> +				err = 1;
>  				break;
>  			}
> +			if (err)
> +				fsck_usage();
> +		}
> +		if (argc > optind) {
> +			c.dbg_lv = 0;
> +			MSG(0, "\tError: Unknown argument %s\n", argv[optind]);
> +			fsck_usage();
>  		}
>  	} else if (!strcmp("dump.f2fs", prog)) {
>  		const char *option_string = "d:i:n:s:a:b:";
> @@ -287,21 +363,6 @@ void f2fs_parse_options(int argc, char *argv[])
>  			}
>  		}
>  	}
> -
> -	if ((optind + 1) != argc) {
> -		MSG(0, "\tError: Device not specified\n");
> -		if (c.func == FSCK)
> -			fsck_usage();
> -		else if (c.func == DUMP)
> -			dump_usage();
> -		else if (c.func == DEFRAG)
> -			defrag_usage();
> -		else if (c.func == RESIZE)
> -			resize_usage();
> -		else if (c.func == SLOAD)
> -			sload_usage();
> -	}
> -	c.device_name = argv[optind];
>  }
> 
>  static void do_fsck(struct f2fs_sb_info *sbi)
> -- 
> 2.10.1
> 
> .
> 
> > 
> >>>  				break;
> >>>  			case 'p':
> >>>  				/* preen mode has different levels:
> >>>  				 *  0: default level, the same as -a
> >>>  				 *  1: check meta
> >>>  				 */
> >>> +				if (optarg[0] == '-') {
> >>> +					c.preen_mode = PREEN_MODE_0;
> >>> +					optind--;
> >>> +					break;
> >>> +				} else if (!is_digits(optarg)) {
> >>> +					MSG(0, "\tError: Wrong option -%c %s\n",
> >>> +							option, optarg);
> >>> +					err = 1;
> >>> +					break;
> >>> +				}
> >>>  				c.preen_mode = atoi(optarg);
> >>>  				if (c.preen_mode < 0)
> >>>  					c.preen_mode = PREEN_MODE_0;
> >>>  				else if (c.preen_mode >= PREEN_MODE_MAX)
> >>> -					c.preen_mode = PREEN_MODE_MAX - 1;
> >>> +					c.preen_mode =
> >>> +						PREEN_MODE_MAX - 1;
> >>>  				if (c.preen_mode == PREEN_MODE_0)
> >>>  					c.auto_fix = 1;
> >>> -				MSG(0, "Info: Fix the reported corruption in "
> >>> -					"preen mode %d\n", c.preen_mode);
> >>> +				MSG(0, "Info: Fix the reported "
> >>> +						"corruption in preen mode %d\n",
> >>> +						c.preen_mode);
> >>>  				break;
> >>>  			case 'd':
> >>> +				if (optarg[0] == '-') {
> >>> +					printf("\tError: Need argument for -%c\n",
> >>> +							option);
> >> In this case, we cannot use -1 as the argument of -d. And a trivial fix: use MSG
> >> instead of printf would be better.
> > 
> > Yup, it doesn't need to allow -1, and I'll change to use MSG.
> > 
> >>> +					err = 1;
> >>> +					break;
> >>> +				} else if (!is_digits(optarg)) {
> >>> +					MSG(0, "\tError: Wrong option -%c %s\n",
> >>> +							option, optarg);
> >>> +					err = 1;
> >>> +					break;
> >>> +				}
> >>>  				c.dbg_lv = atoi(optarg);
> >>> -				MSG(0, "Info: Debug level = %d\n",
> >>> -							c.dbg_lv);
> >>> +				MSG(0, "Info: Debug level = %d\n", c.dbg_lv);
> >>>  				break;
> >>> -			case 'f':
> >>> -				c.fix_on = 1;
> >>> -				MSG(0, "Info: Force to fix corruption\n");
> >>> +			case ':':
> >>> +				__handle_fsck_args(optopt);
> >>>  				break;
> >>> -			case 't':
> >>> -				c.dbg_lv = -1;
> >>> +			case '?':
> >>> +				MSG(0, "\tError: Unknown option %c\n", optopt);
> >>> +				err = 1;
> >>>  				break;
> >>>  			default:
> >>>  				MSG(0, "\tError: Unknown option %c\n", option);
> >>> -				fsck_usage();
> >>> +				err = 1;
> >>>  				break;
> >>
> >> We could integrate '?' and default together, and remove '%c' int the output
> >> message, since it is always '?'.
> > 
> > There-in optopt and option can show different failed option strings.
> > 
> >>
> >> thanks,
> >> Sheng
> >>>  			}
> >>> +			if (err)
> >>> +				fsck_usage();
> >>>  		}
> >>>  	} else if (!strcmp("dump.f2fs", prog)) {
> >>>  		const char *option_string = "d:i:n:s:a:b:";
> >>> @@ -287,21 +373,6 @@ void f2fs_parse_options(int argc, char *argv[])
> >>>  			}
> >>>  		}
> >>>  	}
> >>> -
> >>> -	if ((optind + 1) != argc) {
> >>> -		MSG(0, "\tError: Device not specified\n");
> >>> -		if (c.func == FSCK)
> >>> -			fsck_usage();
> >>> -		else if (c.func == DUMP)
> >>> -			dump_usage();
> >>> -		else if (c.func == DEFRAG)
> >>> -			defrag_usage();
> >>> -		else if (c.func == RESIZE)
> >>> -			resize_usage();
> >>> -		else if (c.func == SLOAD)
> >>> -			sload_usage();
> >>> -	}
> >>> -	c.devices[0].path = strdup(argv[optind]);
> BTW, some a patch which modifies c.device_name seems missing here.
> 
> thanks,
> Sheng
> >>>  }
> >>>  
> >>>  static void do_fsck(struct f2fs_sb_info *sbi)
> >>>
> > 
> > .
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
