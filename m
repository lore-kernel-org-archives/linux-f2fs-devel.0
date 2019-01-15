From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: UBSAN: set boolean value
 iostat_enable correctly
Date: Tue, 15 Jan 2019 09:56:03 +0800
Message-ID: <9a134768-4a5f-49b6-928a-e3ba4a9c8acc@huawei.com>
References: <20190114140514.197758-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gjDxn-0004Si-2W
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 15 Jan 2019 01:56:23 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gjDxl-005Gn2-4I
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 15 Jan 2019 01:56:22 +0000
In-Reply-To: <20190114140514.197758-1-shengyong1@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2019/1/14 22:05, Sheng Yong wrote:
> When setting /sys/fs/f2fs/<DEV>/iostat_enable with non-boolean value,
> UBSAN reports the following warning.
> 
> [ 7562.295484] ================================================================================
> [ 7562.296531] UBSAN: Undefined behaviour in fs/f2fs/f2fs.h:2776:10
> [ 7562.297651] load of value 64 is not a valid value for type '_Bool'
> [ 7562.298642] CPU: 1 PID: 7487 Comm: dd Not tainted 4.20.0-rc4+ #79
> [ 7562.298653] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> [ 7562.298662] Call Trace:
> [ 7562.298760]  dump_stack+0x46/0x5b
> [ 7562.298811]  ubsan_epilogue+0x9/0x40
> [ 7562.298830]  __ubsan_handle_load_invalid_value+0x72/0x90
> [ 7562.298863]  f2fs_file_write_iter+0x29f/0x3f0
> [ 7562.298905]  __vfs_write+0x115/0x160
> [ 7562.298922]  vfs_write+0xa7/0x190
> [ 7562.298934]  ksys_write+0x50/0xc0
> [ 7562.298973]  do_syscall_64+0x4a/0xe0
> [ 7562.298992]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 7562.299001] RIP: 0033:0x7fa45ec19c00
> [ 7562.299004] Code: 73 01 c3 48 8b 0d 88 92 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d dd eb 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ce 8f 01 00 48 89 04 24
> [ 7562.299044] RSP: 002b:00007ffca52b49e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [ 7562.299052] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa45ec19c00
> [ 7562.299059] RDX: 0000000000000400 RSI: 000000000093f000 RDI: 0000000000000001
> [ 7562.299065] RBP: 000000000093f000 R08: 0000000000000004 R09: 0000000000000000
> [ 7562.299071] R10: 00007ffca52b47b0 R11: 0000000000000246 R12: 0000000000000400
> [ 7562.299077] R13: 000000000093f000 R14: 000000000093f400 R15: 0000000000000000
> [ 7562.299091] ================================================================================
> 
> So, if iostat_enable is enabled, set its value as `true'.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>  fs/f2fs/sysfs.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 0575edbe3ed6..b192627742a9 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -278,10 +278,17 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>  		return count;
>  	}
>  
> -	*ui = t;
>  
> -	if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
> -		f2fs_reset_iostat(sbi);
> +	if (!strcmp(a->attr.name, "iostat_enable")) {

		bool enable = !!*ui;

		if (!enable)
			f2fs_reset_iostat(sbi);
		sbi->iostat_enable = enable;

		return count;

> +		if (t == 0)
> +			f2fs_reset_iostat(sbi);
> +		else
> +			sbi->iostat_enable = true;
> +		return count;
> +	}
> +
> +	*ui = (unsigned int)t;
> +
>  	return count;
>  }
>  
> 
