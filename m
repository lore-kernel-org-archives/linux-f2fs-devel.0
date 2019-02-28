From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/4] f2fs_io: add write
Date: Thu, 28 Feb 2019 09:35:42 +0800
Message-ID: <571cefb4-cce4-df1d-7e60-12417f44f366@huawei.com>
References: <20190220170745.7328-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gzAcD-0003fw-3d
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Feb 2019 01:36:01 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gzAcA-00D5av-PU
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Feb 2019 01:36:01 +0000
In-Reply-To: <20190220170745.7328-1-jaegeuk@kernel.org>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@google.com>

On 2019/2/21 1:07, Jaegeuk Kim wrote:
> From: Jaegeuk Kim <jaegeuk@google.com>
> 
> f2fs_io write [chunk_size in 4kb] [offset in chunk_size] [count] [pattern] [IO] [file_path]
> 
> Write given patten data in file_path
> pattern can be
>   zero     : zeros
>   inc_num  : incrementing numbers
>   rand     : random numbers
> IO can be
>   buffered : buffered IO
>   dio      : direct IO
> 
> Change-Id: Icc866d5b9933423639d1d0e4d5e556ddf4f15feb
> Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
> ---
>  tools/f2fs_io/f2fs_io.c | 88 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> index c39273e..0515108 100644
> --- a/tools/f2fs_io/f2fs_io.c
> +++ b/tools/f2fs_io/f2fs_io.c
> @@ -15,8 +15,12 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> +#include <time.h>
> +#include <string.h>
>  #include <signal.h>
>  #include <termios.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
>  
>  #ifdef HAVE_CONFIG_H
>  #include "config.h"
> @@ -127,6 +131,89 @@ static void do_pinfile(int argc, char **argv, const struct cmd_desc *cmd)
>  	exit(0);
>  }
>  
> +#define write_desc "write data into file"
> +#define write_help					\
> +"f2fs_io write [chunk_size in 4kb] [offset in chunk_size] [count] [pattern] [IO] [file_path]\n\n"	\
> +"Write given patten data in file_path\n"		\
> +"pattern can be\n"					\
> +"  zero     : zeros\n"					\
> +"  inc_num  : incrementing numbers\n"			\
> +"  rand     : random numbers\n"				\
> +"IO can be\n"						\
> +"  buffered : buffered IO\n"				\
> +"  dio      : direct IO\n"				\
> +
> +static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
> +{
> +	u64 buf_size = 0, inc_num = 0, ret = 0, written = 0;
> +	loff_t offset;
> +	char *buf = NULL;
> +	unsigned bs, count, i;
> +	int flags = 0;
> +	int fd;
> +
> +	srand(time(0));
> +
> +	if (argc != 7) {
> +		fputs("Excess arguments\n\n", stderr);
> +		fputs(cmd->cmd_help, stderr);
> +		exit(1);
> +	}
> +
> +	bs = atoi(argv[1]);
> +	if (bs > 1024) {
> +		fputs("Too big chunk size - limit: 4MB\n\n", stderr);
> +		exit(1);
> +	}
> +	buf_size = bs * 4096;
> +
> +	offset = atoi(argv[2]) * buf_size;
> +
> +	buf = aligned_alloc(4096, buf_size);
> +	if (!buf) {
> +		fputs("Memory alloc failed\n\n", stderr);
> +		exit(1);
> +	}
> +	count = atoi(argv[3]);
> +
> +	if (!strcmp(argv[4], "zero")) {
> +		memset(buf, 0, buf_size);
> +	} else if (strcmp(argv[4], "inc_num") &&
> +			strcmp(argv[4], "rand")) {
> +		fputs("Wrong pattern type\n\n", stderr);
> +		exit(1);
> +	}
> +
> +	if (!strcmp(argv[5], "buffered")) {
> +		flags |= O_DIRECT;
> +	} else if (strcmp(argv[5], "dio")) {
> +		fputs("Wrong IO type\n\n", stderr);
> +		exit(1);
> +	}

should be

if (!strcmp(, dio)) {
	flags |= O_DIRECT;
} else if (strcmp(, buffered)) {
	fputs();
}

> +
> +	fd = open(argv[6], O_CREAT | O_WRONLY | flags, 0755);
> +	if (fd == -1) {
> +		fputs("Open failed\n\n", stderr);
> +		exit(1);
> +	}
> +
> +	for (i = 0; i < count; i++) {
> +		if (!strcmp(argv[4], "inc_num"))
> +			*(int *)buf = inc_num++;
> +		else if (!strcmp(argv[4], "rand"))
> +			*(int *)buf = rand();
> +
> +		/* write data */
> +		ret = pwrite(fd, buf, buf_size, offset + buf_size * i);
> +		if (ret != buf_size)
> +			break;
> +		written += ret;
> +	}
> +
> +	printf("Written %lu bytes with pattern=%s\n", written, argv[4]);
> +	exit(0);
> +}
> +
>  #define CMD_HIDDEN 	0x0001
>  #define CMD(name) { #name, do_##name, name##_desc, name##_help, 0 }
>  #define _CMD(name) { #name, do_##name, NULL, NULL, CMD_HIDDEN }
> @@ -136,6 +223,7 @@ const struct cmd_desc cmd_list[] = {
>  	_CMD(help),
>  	CMD(shutdown),
>  	CMD(pinfile),
> +	CMD(write),
>  	{ NULL, NULL, NULL, NULL, 0 }
>  };
>  
> 
