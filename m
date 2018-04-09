From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] fsck.f2fs: recover nat bits feature default
 by fsck
Date: Mon, 9 Apr 2018 18:59:40 +0800
Message-ID: <962dc39b-521a-cf01-83bd-119f4b842345@huawei.com>
References: <1523244881-13125-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f5UWw-0006aG-Q5
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Apr 2018 11:00:10 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f5UWs-00HP2a-Rx
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Apr 2018 11:00:10 +0000
In-Reply-To: <1523244881-13125-1-git-send-email-heyunlei@huawei.com>
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
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: zhangdianfang@huawei.com

On 2018/4/9 11:34, Yunlei He wrote:
> Now, nat bits feature is enabled by default, we will
> meet with the following scenarios:
> 
> i.   disabled, without CP_NAT_BITS_FLAG, if fsck find some
>      fs errors, fix or write new checkpoint will then enable it.
> ii.  enabled, with CP_NAT_BITS_FLAG, in the case of sudden
>      power off, bitmap will get lost but CP_NAT_BITS_FLAG
>      still exist, fsck will recover bitmap in f2fs_do_mount.
> iii. enabled, with CP_NAT_BITS_FLAG, both of bitmap and
>      CP_NAT_BITS_FLAG will get lost if not enough space for
>      nat bits or nat bits check failed during mounting.
>      SBI_NEED_FSCK is set, fsck will recover flag and bitmap
>      before next mount.
> 
> SBI_NEED_FSCK means fs is corrupted, is not suitable for
> nat bits disabled. This patch try to recover nat bits all
> by fsck, no need set SBI_NEED_FSCK flag in kernel.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
