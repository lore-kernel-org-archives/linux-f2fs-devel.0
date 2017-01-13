From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 5/6] f2fs: add a kernel thread to issue
 discard commands asynchronously
Date: Fri, 13 Jan 2017 11:12:11 -0800
Message-ID: <20170113191211.GB1301@jaegeuk.local>
References: <20170112224407.54026-1-jaegeuk@kernel.org>
	<20170112224407.54026-5-jaegeuk@kernel.org>
	<20170113080159.GB31777@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cS7Gu-0007Bi-CH
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Jan 2017 19:12:20 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cS7Gt-0002nB-ML
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Jan 2017 19:12:20 +0000
Content-Disposition: inline
In-Reply-To: <20170113080159.GB31777@infradead.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 01/13, Christoph Hellwig wrote:
> On Thu, Jan 12, 2017 at 02:44:06PM -0800, Jaegeuk Kim wrote:
> > This patch adds a kernel thread to issue discard commands.
> > It proposes three states, D_PREP, D_SUBMIT, and D_DONE to identify current
> > bio status.
> 
> Why?  Instead of creating the complexity of a thread you should look
> into issuing the discard bios asynchronously, which should help to
> simplify a lot of the discard logic in f2fs.

Previously, I've done to issue discard bios asynchronously. But the problem that
I've got is that was not enough. When testing nvme SSD with noop IO scheduler,
submit_bio() was blocked at every 8 async discard bios, resulting in very slow
checkpoint process which blocks most of other FS operations.

Thanks,

------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
