From: Sasha Levin <sasha.levin@oracle.com>
Subject: Re: f2fs: kernel BUG at fs/f2fs/segment.h:543
Date: Sun, 06 Apr 2014 21:55:26 -0400
Message-ID: <5342058E.4090500@oracle.com>
References: <53401D4A.1020203@oracle.com> <1396833642.12401.12.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sasha.levin@oracle.com>) id 1WWymf-0001PP-Sf
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Apr 2014 01:55:37 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WWymf-0005je-6I
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Apr 2014 01:55:37 +0000
In-Reply-To: <1396833642.12401.12.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: Dave Jones <davej@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On 04/06/2014 09:20 PM, Jaegeuk Kim wrote:
> Hi,
> 
> Thank you for the report.
> 
> If possible, could you share fsck.f2fs or dump.f2fs on the corrupted
> partition?
> 
> Otherwise, how about this?
> # fdisk /dev/sdx
>> > p

Hey Jaegeuk,

Unfortunately it was a temporary filesystem inside the fuzzer that has
gone away as soon as the kernel died, so I don't have access to it.


Thanks,
Sasha

------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees_APR
