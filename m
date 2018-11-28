From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/7] ext4: use IS_VERITY() to check inode's
 fsverity status
Date: Wed, 28 Nov 2018 19:19:16 +0530
Message-ID: <2147521.jaMCgNecB2@localhost.localdomain>
References: <20181119052324.31456-1-chandan@linux.vnet.ibm.com>
 <20181119052324.31456-6-chandan@linux.vnet.ibm.com>
 <20181126173615.GB22888@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.vnet.ibm.com>) id 1gS0Dl-0007P7-C0
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Nov 2018 13:49:41 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gS0DV-001wI3-RG
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Nov 2018 13:49:41 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wASDmm64015279
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 28 Nov 2018 08:49:17 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p1tcq5bjx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 28 Nov 2018 08:49:17 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.vnet.ibm.com>;
 Wed, 28 Nov 2018 13:49:15 -0000
In-Reply-To: <20181126173615.GB22888@thunk.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: ebiggers@kernel.org, linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Monday, November 26, 2018 11:06:15 PM IST Theodore Y. Ts'o wrote:
> On Mon, Nov 19, 2018 at 10:53:22AM +0530, Chandan Rajendra wrote:
> > This commit now uses IS_VERITY() macro to check if fsverity is
> > enabled on an inode.
> > 
> > Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> 
> This patch causes a massive number of fsverity tests.  I suspect it's
> due to a mismatch between the ext4's inode flags as opposed to the VFS
> inode's flags.  I'll take a closer look in the next day or two.
> 
> Cheers,
> 
> 						- Ted
> 
> 

Hi Ted,

I have fixed the problem. I will check the fix once again tomorrow and execute
the tests. I will be able to post the patches by end of tomorrow.

I will take a look at the commits that you have added at
git://git.kernel.org/pub/scm/linux/kernel/git/tytso/fscrypt.git test-working
tomorrow.

-- 
chandan
