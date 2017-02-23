From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 5/5] f2fs: avoid out-of-order execution of
 atomic writes
Date: Thu, 23 Feb 2017 17:22:46 +0800
Message-ID: <a3d6d263-1b37-0d67-b8da-603f9f50548c@huawei.com>
References: <20170203234816.12723-1-jaegeuk@kernel.org>
	<20170203234816.12723-5-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cgpc5-0003lg-7C
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 09:23:01 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cgpc4-0003wX-CF
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 09:23:01 +0000
In-Reply-To: <20170203234816.12723-5-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/2/4 7:48, Jaegeuk Kim wrote:
> We need to flush data writes before flushing last node block writes by using
> FUA with PREFLUSH. We don't need to guarantee precedent node writes since if
> those are not written, we can't reach to the last node block when scanning
> node block chain during roll-forward recovery.
> Afterwards f2fs_wait_on_page_writeback guarantees all the IO submission to
> disk, which builds a valid node block chain.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
