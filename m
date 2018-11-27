From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/7] fsverity: Remove filesystem specific
 build config option
Date: Tue, 27 Nov 2018 19:01:28 +0530
Message-ID: <2413763.K7ZbsYlPLa@localhost.localdomain>
References: <20181119052324.31456-1-chandan@linux.vnet.ibm.com>
 <20181119052324.31456-8-chandan@linux.vnet.ibm.com>
 <20181127004530.GF11663@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.vnet.ibm.com>) id 1gRdSy-0004Eq-VP
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Nov 2018 13:31:52 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gRdSp-005oTW-BA
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Nov 2018 13:31:52 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wARDP1fv120256
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 27 Nov 2018 08:31:37 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p13g5s34r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 27 Nov 2018 08:31:36 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.vnet.ibm.com>;
 Tue, 27 Nov 2018 13:31:29 -0000
In-Reply-To: <20181127004530.GF11663@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net

On Tuesday, November 27, 2018 6:15:30 AM IST Eric Biggers wrote:
> Hi Chandan,
> 
> On Mon, Nov 19, 2018 at 10:53:24AM +0530, Chandan Rajendra wrote:
> > In order to have a common code base for fsverity "post read" processing
> > for all filesystems which support per-file verity, this commit removes
> > filesystem specific build config option (e.g. CONFIG_EXT4_FS_VERITY) and
> > replaces it with a build option (i.e. CONFIG_FS_VERITY) whose value
> > affects all the filesystems making use of fsverity.
> > 
> > Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> 
> Like the corresponding fscrypt patch, this is missing changing
> 
> #if IS_ENABLED(CONFIG_FS_VERITY)
> 
> in include/linux/fs.h to
> 
> #ifdef CONFIG_FS_VERITY
> 
> There are also references to the filesystem-specific config options in
> Documentation/filesystems/fsverity.rst that need to be updated.
> 
> I also suggest updating the Kconfig help text for CONFIG_FS_VERITY and
> CONFIG_FS_ENCRYPTION to mention the supported filesystems, similar to how
> CONFIG_QUOTA lists the filesystems it supports.
> 

I will fix this one too.

-- 
chandan
