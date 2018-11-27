From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/7] Add S_VERITY and IS_VERITY()
Date: Tue, 27 Nov 2018 19:00:21 +0530
Message-ID: <2582039.3lrkY9mNPa@localhost.localdomain>
References: <20181119052324.31456-1-chandan@linux.vnet.ibm.com>
 <20181119052324.31456-5-chandan@linux.vnet.ibm.com>
 <20181127000836.GA11663@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.vnet.ibm.com>) id 1gRdRv-0006So-Pz
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Nov 2018 13:30:47 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gRdRg-005oNU-BJ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Nov 2018 13:30:47 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wARDOJLI064030
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 27 Nov 2018 08:30:24 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p15a9ceup-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 27 Nov 2018 08:30:23 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.vnet.ibm.com>;
 Tue, 27 Nov 2018 13:30:22 -0000
In-Reply-To: <20181127000836.GA11663@gmail.com>
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

On Tuesday, November 27, 2018 5:38:38 AM IST Eric Biggers wrote:
> Hi Chandan,
> 
> On Mon, Nov 19, 2018 at 10:53:21AM +0530, Chandan Rajendra wrote:
> > Similar to S_ENCRYPTED/IS_ENCRYPTED(), this commit adds
> > S_VERITY/IS_VERITY() to be able to check if a VFS inode has verity
> > information associated with it.
> > 
> > Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> > ---
> >  include/linux/fs.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index bcfc40062757..8129617c9718 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1938,6 +1938,7 @@ struct super_operations {
> >  #define S_DAX		0	/* Make all the DAX code disappear */
> >  #endif
> >  #define S_ENCRYPTED	16384	/* Encrypted file (using fs/crypto/) */
> > +#define S_VERITY	32768	/* File with fsverity info (using fs/verity) */
> >  
> 
> The comment for S_VERITY is misleading because IS_VERITY() is used to check
> whether the verity bit is set *before* the fsverity_info is created.
> 
> Can you change it to just mirror the fscrypt comment?
> 
> #define S_VERITY	32768	/* Verity file (using fs/verity/) */

I will fix this up.

-- 
chandan
