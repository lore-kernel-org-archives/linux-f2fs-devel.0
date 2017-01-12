From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: make discard command directly
Date: Thu, 12 Jan 2017 10:39:17 -0800
Message-ID: <20170112183917.GA48403@jaegeuk.local>
References: <20170112004848.37202-1-jaegeuk@kernel.org>
	<20170112141010.GA25952@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cRkHZ-0002sd-T4
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Jan 2017 18:39:29 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cRkHY-0003dq-Sd
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Jan 2017 18:39:29 +0000
Content-Disposition: inline
In-Reply-To: <20170112141010.GA25952@infradead.org>
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

On 01/12, Christoph Hellwig wrote:
> On Wed, Jan 11, 2017 at 04:48:48PM -0800, Jaegeuk Kim wrote:
> > This can reduce the backporting efforts.
> 
> NAK.  For one that is not a valid excuse for anything, and second
> your remove respecting the granularity.

Okay, I'll try from backporting side without this. :)

Thanks,

------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
