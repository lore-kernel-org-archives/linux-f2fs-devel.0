From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev]  Not use inline_data  after file shrink
Date: Fri, 29 May 2015 15:41:41 -0700
Message-ID: <20150529224141.GA24511@jaegeuk-mac02.mot.com>
References: <5567F382.5060403@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5567F382.5060403@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: He YunLei <heyunlei@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, Bintian <bintian.wang@huawei.com>, hujianyang@huawei.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Yunlei,

On Fri, May 29, 2015 at 01:05:06PM +0800, He YunLei wrote:
> Hi Jaegeuk,
> 
> I found that when files(size > MAX_INLINE_DATA) shrink(size < MAX_INLINE_DATA),
> inline_data option is not used in the file after narrow    	
> 
> I mount f2fs with inline_data as follow:
> 
> /dev/block/mmcblk0p40 /data f2fs rw,nosuid,nodev,noatime,background_gc=on,discard,
> user_xattr,inline_xattr,acl,inline_data,active_logs=6 0 0
> 
> First,I create a small file by command echo for testing inline_data.
> 
> root@hyl:/data # echo 123 > tmp1
> root@hyl:/data # busybox stat tmp1
>   File: tmp1
>   Size: 4               Blocks: 8          IO Block: 4096   regular file
> Device: 10300h/66304d   Inode: 2173        Links: 1
> Access: (0666/-rw-rw-rw-)  Uid: (    0/ UNKNOWN)   Gid: (    0/ UNKNOWN)
> Access: 2015-05-29 02:59:53.000000000
> Modify: 2015-05-29 02:59:53.000000000
> Change: 2015-05-29 02:59:53.000000000
> 
> It works well, then I create a file with size 4096(>MAX_INLINE_DATA).
> 
> 127|root@hyl:/data # busybox stat tmp
>   File: tmp
>   Size: 4096            Blocks: 16         IO Block: 4096   regular file
> Device: 10300h/66304d   Inode: 109         Links: 1
> Access: (0666/-rw-rw-rw-)  Uid: (    0/ UNKNOWN)   Gid: (    0/ UNKNOWN)
> Access: 2015-05-28 08:48:50.000000000
> Modify: 2015-05-28 08:48:50.000000000
> Change: 2015-05-28 08:53:18.000000000
> 
> It doesn't use inline_data because file size 4096 > MAX_INLINE_DATA,
> So I shrink the file by I/O redirection
> 
> root@hyl:/data # echo 123 > tmp
> root@hyl:/data # busybox stat tmp
>   File: tmp
>   Size: 4               Blocks: 16         IO Block: 4096   regular file
> Device: 10300h/66304d   Inode: 109         Links: 1
> Access: (0666/-rw-rw-rw-)  Uid: (    0/ UNKNOWN)   Gid: (    0/ UNKNOWN)
> Access: 2015-05-28 08:48:50.000000000
> Modify: 2015-05-29 02:58:31.000000000
> Change: 2015-05-29 02:58:31.000000000
> 
> We can see that file still uses 16 Blocks
> 
> How do we deal with such situation? it's meaningful to reuse inline_data?
> I wish you and other developers in this list could help me in a correct way.

As Chao mentioned, inline_data is not recoverable; once it is unset, there is
no way to set again. The reason is to avoid live/deadlock, data loss after
power-cuts, and another heavy lock contention overhead.

Historically, Huajun Li [1] implemented recoverable inline_data, but I decided
to removed that due to lots of subtle bugs.

[1] http://lwn.net/Articles/573408/

> 
> Thanks,
> He
