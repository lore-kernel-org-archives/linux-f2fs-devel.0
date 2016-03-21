From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] f2fs: support access control via key
	management
Date: Mon, 21 Mar 2016 08:39:38 -0700
Message-ID: <20160321153938.GB27230@infradead.org>
References: <1457571168-56724-1-git-send-email-jaegeuk@kernel.org>
	<20160315072422.GB11669@infradead.org>
	<20160315163725.GA78436@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from
	<BATV+e8622a914439b518f42a+4593+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1ai1vo-000882-Ip for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Mar 2016 15:39:48 +0000
Received: from bombadil.infradead.org ([198.137.202.9])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ai1vl-0001sk-Iq
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Mar 2016 15:39:48 +0000
Content-Disposition: inline
In-Reply-To: <20160315163725.GA78436@jaegeuk.gateway>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Tue, Mar 15, 2016 at 09:37:25AM -0700, Jaegeuk Kim wrote:
> I agree that I must follow FS convention here.
> But, in order to make this clear out, could you please elaborate why this is not
> allowed?
> 
> I wrote this patch totally based on per-file encryption in which users cannot
> access their files if they have no right key.
> The only difference is that this controls user access with a key only, neither
> encrypting file data nor dentries.
> 
> This was initiated by UX in android letting nobody be able to access the files
> that owner wants to protect by passcode or fingerprint.
> 
> Does it make no sense to support this by filesystems?

I don't think it does.  But if you want to argue for it you should

 a) support it in the VFS
 b) document the exact semantics
 c) ensure linux-man and linux-api are on the Cc list.

------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
