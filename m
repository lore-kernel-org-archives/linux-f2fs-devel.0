From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 3/4] f2fs crypto: check encryption for tmpfile
Date: Wed, 20 May 2015 00:46:04 -0400
Message-ID: <20150520044604.GD2871@thunk.org>
References: <1432082606-55975-1-git-send-email-jaegeuk@kernel.org>
	<1432082606-55975-3-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tytso@thunk.org>) id 1YuvtV-0006fd-1q
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 May 2015 04:46:13 +0000
Received: from imap.thunk.org ([74.207.234.97])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1YuvtU-0000jF-8I
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 May 2015 04:46:13 +0000
Content-Disposition: inline
In-Reply-To: <1432082606-55975-3-git-send-email-jaegeuk@kernel.org>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Tue, May 19, 2015 at 05:43:25PM -0700, Jaegeuk Kim wrote:
> This patch adds to check encryption for tmpfile in early stage.

Don't you also need a call to ext4_inherit_context(dir, inode) here?
(I need to fix this for ext4 as well).

					- Ted

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
