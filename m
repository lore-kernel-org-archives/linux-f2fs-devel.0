From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: cp hangs with large source tree
Date: Wed, 25 Jun 2014 16:43:43 +0900
Message-ID: <20140625074342.GA8262@jmac.local>
References: <53AA6005.2030405@westnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Wzhs4-0007iA-3I
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 Jun 2014 07:43:56 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wzhs2-0000vq-DE for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 Jun 2014 07:43:56 +0000
Content-Disposition: inline
In-Reply-To: <53AA6005.2030405@westnet.com.au>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Brian Chadwick <brianchad@westnet.com.au>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Brian,

Could you share your partition and DRAM sizes?

In addition, when cp hangs, could you share its process backtrace?
# cat /proc/[pid]/stack

Thanks,

On Wed, Jun 25, 2014 at 03:37:09PM +1000, Brian Chadwick wrote:
> Hi,
> 
> Kernel 3.15.0 ... I tried copying a large tree full of many small files 
> (kernel source) onto a drive formatted with F2FS. The copy seems to 
> proceed normally, but when all files appear to be copied, cp seems to 
> hang and does not seem to terminate properly. Its waiting for something 
> I assume. This also happens with 3.16.0-rc{1,2}. cp responds to Ctrl-C 
> and terminates, and the files appear to be there on the F2FS partition.
> 
> It works as expected with Kernel 3.14.8
> 
> Any clues?
> 
> Brian
> 
> ------------------------------------------------------------------------------
> Open source business process management suite built on Java and Eclipse
> Turn processes into business applications with Bonita BPM Community Edition
> Quickly connect people, data, and systems into organized workflows
> Winner of BOSSIE, CODIE, OW2 and Gartner awards
> http://p.sf.net/sfu/Bonitasoft
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

-- 
Jaegeuk Kim

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
