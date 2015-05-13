From: nick <xerofoify@gmail.com>
Subject: Re: [PATCH 03/18] f2fs crypto: declare some definitions
 for f2fs encryption feature
Date: Tue, 12 May 2015 22:23:48 -0400
Message-ID: <5552B5B4.8060007@gmail.com>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>	<1431145253-2019-3-git-send-email-jaegeuk@kernel.org>
	<20150513020208.GK15721@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xerofoify@gmail.com>) id 1YsML2-0000Um-4E
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 13 May 2015 02:24:00 +0000
Received: from mail-ig0-f173.google.com ([209.85.213.173])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YsMKy-0003W4-Nl
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 13 May 2015 02:24:00 +0000
Received: by iget9 with SMTP id t9so107286874ige.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 12 May 2015 19:23:51 -0700 (PDT)
In-Reply-To: <20150513020208.GK15721@dastard>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dave Chinner <david@fromorbit.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net



On 2015-05-12 10:02 PM, Dave Chinner wrote:
> On Fri, May 08, 2015 at 09:20:38PM -0700, Jaegeuk Kim wrote:
>> This definitions will be used by inode and superblock for encyption.
> 
> How much of this crypto stuff is common with or only slightly
> modified from the ext4 code?  Is the behaviour and features the
> same? Is the user API and management tools the same?
> 
> IMO, if there is any amount of overlap, then we should be
> implementing this stuff as generic code, not propagating the same
> code through multiple filesystems via copy-n-paste-n-modify. This
> will simply end up with diverging code, different bugs and feature
> sets, and none of the implementations will get the review and
> maintenance they really require...
> 
> And, FWIW, this is the reason why I originally asked for the ext4
> encryption code to be pulled up to the VFS: precisely so we didn't
> end up with a rapid proliferation of individual in-filesystem
> encryption implementations that are all slightly different...
> 
> Cheers,
> 
> Dave.
> 
Dave,
I have been only reading this discussion for the last few so I may miss a thing or two.
Firstly, I have to agree with you on moving the encryption code from the ext4 code base
to the VFS layer so other file systems can reuse it. Further more I am curious if you can
help me understand why the ext4 developers have decided not to do this as it seems illogical
to me. Clearly a reusable core for file system encryption is ideal where the file systems
only change it for their internal lay out and design differences much like the way super
blocks are handled now in the VFS and by the different file systems that Linux supports.
Nick 

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
