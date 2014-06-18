From: Jeff Liu <jeff.liu@oracle.com>
Subject: Re: [PATCH 21/24] f2fs: return actual error on
	init_f2fs_fs
Date: Wed, 18 Jun 2014 09:50:30 +0800
Message-ID: <53A0F066.8040507@oracle.com>
References: <53A05190.60600@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jeff.liu@oracle.com>) id 1Wx51T-0006en-Ms
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 18 Jun 2014 01:50:47 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wx51R-0004hI-Rh
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 18 Jun 2014 01:50:47 +0000
In-Reply-To: <53A05190.60600@oracle.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, cm224.lee@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi,

On 06/17/2014 22:32 PM, Jeff Liu wrote:
> From: Jie Liu <jeff.liu@oracle.com>
> 
> Return the actual error code if kset_create_and_add() failed
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Changman Lee <cm224.lee@samsung.com>
> Signed-off-by: Jie Liu <jeff.liu@oracle.com>

Please ignore this patch because Greg think that is incorrect.

Cheers,
-Jeff

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
