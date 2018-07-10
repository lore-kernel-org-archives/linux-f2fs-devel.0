From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix defined but not used build warnings
Date: Tue, 10 Jul 2018 09:09:44 +0800
Message-ID: <b6f9275a-854a-d9e3-271b-b2671acd6041@huawei.com>
References: <4463b606-3373-2e51-ad8c-3303b1ccc587@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fchAe-0001ba-1Z
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Jul 2018 01:10:24 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fchAc-004iOU-2S
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Jul 2018 01:10:23 +0000
In-Reply-To: <4463b606-3373-2e51-ad8c-3303b1ccc587@infradead.org>
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
To: Randy Dunlap <rdunlap@infradead.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>

On 2018/7/7 11:50, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build warnings in f2fs when CONFIG_PROC_FS is not enabled
> by marking the unused functions as __maybe_unused.
> 
> ../fs/f2fs/sysfs.c:519:12: warning: 'segment_info_seq_show' defined but not used [-Wunused-function]
> ../fs/f2fs/sysfs.c:546:12: warning: 'segment_bits_seq_show' defined but not used [-Wunused-function]
> ../fs/f2fs/sysfs.c:570:12: warning: 'iostat_info_seq_show' defined but not used [-Wunused-function]
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <yuchao0@huawei.com>
> Cc: linux-f2fs-devel@lists.sourceforge.net

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
