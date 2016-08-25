From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/3] f2fs: schedule in between two continous
 batch discards
Date: Thu, 25 Aug 2016 09:57:16 -0700
Message-ID: <20160825165716.GA84318@jaegeuk>
References: <1471792891-2388-1-git-send-email-chao@kernel.org>
	<1471792891-2388-2-git-send-email-chao@kernel.org>
	<20160823165353.GA73835@jaegeuk>
	<bc8702e8-5565-e3de-cefb-48dde02dbd6f@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bcxy2-00052O-SN
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Aug 2016 16:57:26 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bcxy0-00017u-Rn
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Aug 2016 16:57:26 +0000
Content-Disposition: inline
In-Reply-To: <bc8702e8-5565-e3de-cefb-48dde02dbd6f@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Thu, Aug 25, 2016 at 05:22:29PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2016/8/24 0:53, Jaegeuk Kim wrote:
> > Hi Chao,
> > 
> > On Sun, Aug 21, 2016 at 11:21:30PM +0800, Chao Yu wrote:
> >> From: Chao Yu <yuchao0@huawei.com>
> >>
> >> In batch discard approach of fstrim will grab/release gc_mutex lock
> >> repeatly, it makes contention of the lock becoming more intensive.
> >>
> >> So after one batch discards were issued in checkpoint and the lock
> >> was released, it's better to do schedule() to increase opportunity
> >> of grabbing gc_mutex lock for other competitors.
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/segment.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >> index 020767c..d0f74eb 100644
> >> --- a/fs/f2fs/segment.c
> >> +++ b/fs/f2fs/segment.c
> >> @@ -1305,6 +1305,8 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
> >>  		mutex_unlock(&sbi->gc_mutex);
> >>  		if (err)
> >>  			break;
> >> +
> >> +		schedule();
> > 
> > Hmm, if other thread is already waiting for gc_mutex, we don't need this here.
> > In order to avoid long latency, wouldn't it be enough to reduce the batch size?
> 
> Hmm, when fstrim call mutex_unlock we will pop one blocked locker from FIFO list
> of mutex lock, and wake it up, then fstrimer will try to lock gc_mutex for next
> batch trim, so the popped locker and fstrimer will make a new competition in
> gc_mutex.

Before trying to grab gc_mutex by fstrim again, there are already blocked tasks
waiting for gc_mutex. Hence the next one should be selectec by FIFO, no?

Thanks,

> If fstrimer is running in a big core, and popped locker is running in
> a small core, we can't guarantee popped locker can win the race, and for the
> most of time, fstrimer will win. So in order to reduce starvation of other
> gc_mutext locker, it's better to do schedule() here.
> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> >>  	}
> >>  out:
> >>  	range->len = F2FS_BLK_TO_BYTES(cpc.trimmed);
> >> -- 
> >> 2.7.2
> > 
> > .
> > 

------------------------------------------------------------------------------
