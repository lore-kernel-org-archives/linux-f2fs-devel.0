From: He YunLei <heyunlei@huawei.com>
Subject: Re: [PATCH] mkfs.f2fs: introduce -b option to support
 specified fs size formating
Date: Sat, 14 Nov 2015 13:32:29 +0800
Message-ID: <5646C76D.3010802@huawei.com>
References: <01ab01d11b94$a3231470$e9693d50$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1ZxTSW-0006gc-DH
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 Nov 2015 05:33:08 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZxTST-0004cS-0u
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 Nov 2015 05:33:08 +0000
In-Reply-To: <01ab01d11b94$a3231470$e9693d50$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

hi,

We can specify fs size in function f2fs_parse_options as follow:
     if ((optind + 1) < argc) {
         /* We have a sector count. */
         config.total_sectors = atoll(argv[optind+1]);
which one is better?

Thanks

On 2015/11/10 16:48, Chao Yu wrote:
> This patch introduces a new option '-b', with this option user can specify
> required fs size for formating. _scratch_mkfs_sized in xfstest is one of
> user cases.
>
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>   include/f2fs_fs.h       | 1 +
>   lib/libf2fs.c           | 9 +++++++--
>   mkfs/f2fs_format_main.c | 6 +++++-
>   3 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index 359deec..dedc143 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -223,6 +223,7 @@ enum f2fs_config_func {
>   };
>
>   struct f2fs_configuration {
> +	u_int64_t fs_size;
>   	u_int32_t sector_size;
>   	u_int32_t reserved_segments;
>   	double overprovision;
> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> index 33a82aa..e755f20 100644
> --- a/lib/libf2fs.c
> +++ b/lib/libf2fs.c
> @@ -347,6 +347,7 @@ int f2fs_crc_valid(u_int32_t blk_crc, void *buf, int len)
>    */
>   void f2fs_init_configuration(struct f2fs_configuration *c)
>   {
> +	c->fs_size = 0;
>   	c->total_sectors = 0;
>   	c->sector_size = DEFAULT_SECTOR_SIZE;
>   	c->sectors_per_blk = DEFAULT_SECTORS_PER_BLOCK;
> @@ -473,15 +474,19 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
>   			MSG(0, "\tError: Cannot get the device size\n");
>   			return -1;
>   		}
> -		c->total_sectors /= c->sector_size;
>   #else
>   		if (ioctl(fd, BLKGETSIZE, &total_sectors) < 0) {
>   			MSG(0, "\tError: Cannot get the device size\n");
>   			return -1;
>   		}
> -		total_sectors /= c->sector_size;
>   		c->total_sectors = total_sectors;
>   #endif
> +		if (c->fs_size && c->fs_size < c->total_sectors)
> +			c->total_sectors = (c->fs_size + c->sector_size - 1) /
> +								c->sector_size;
> +		else
> +			c->total_sectors /= c->sector_size;
> +
>   		if (ioctl(fd, HDIO_GETGEO, &geom) < 0)
>   			c->start_sector = 0;
>   		else
> diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
> index 2ea809c..07f101f 100644
> --- a/mkfs/f2fs_format_main.c
> +++ b/mkfs/f2fs_format_main.c
> @@ -29,6 +29,7 @@ static void mkfs_usage()
>   	MSG(0, "\nUsage: mkfs.f2fs [options] device [sectors]\n");
>   	MSG(0, "[options]:\n");
>   	MSG(0, "  -a heap-based allocation [default:1]\n");
> +	MSG(0, "  -b file system size\n");
>   	MSG(0, "  -d debug level [default:0]\n");
>   	MSG(0, "  -e [extension list] e.g. \"mp3,gif,mov\"\n");
>   	MSG(0, "  -l label\n");
> @@ -73,7 +74,7 @@ static void parse_feature(char *features)
>
>   static void f2fs_parse_options(int argc, char *argv[])
>   {
> -	static const char *option_string = "qa:d:e:l:o:O:s:z:t:";
> +	static const char *option_string = "qa:b:d:e:l:o:O:s:z:t:";
>   	int32_t option=0;
>
>   	while ((option = getopt(argc,argv,option_string)) != EOF) {
> @@ -84,6 +85,9 @@ static void f2fs_parse_options(int argc, char *argv[])
>   		case 'a':
>   			config.heap = atoi(optarg);
>   			break;
> +		case 'b':
> +			config.fs_size = atoll(optarg);
> +			break;
>   		case 'd':
>   			config.dbg_lv = atoi(optarg);
>   			break;
>


------------------------------------------------------------------------------
