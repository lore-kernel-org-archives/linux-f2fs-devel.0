From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: Re: [RFC PATCH 08/10] fsverity: Add call back to verify
 file holes
Date: Thu, 21 Feb 2019 18:35:48 +0530
Message-ID: <3402546.YtSmlxULMa@localhost.localdomain>
References: <20190218100433.20048-1-chandan@linux.ibm.com>
 <20190218100433.20048-9-chandan@linux.ibm.com>
 <20190220003507.GH12177@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1gwoSt-0005y3-ID
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Feb 2019 13:32:39 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gwoSs-005BAC-3u
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Feb 2019 13:32:39 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1LDUHOw130528
 for <linux-f2fs-devel@lists.sourceforge.net>; Thu, 21 Feb 2019 08:32:32 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qsun4bmtn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Thu, 21 Feb 2019 08:32:30 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Thu, 21 Feb 2019 13:32:27 -0000
In-Reply-To: <20190220003507.GH12177@gmail.com>
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
Cc: tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, adilger.kernel@dilger.ca, jaegeuk@kernel.org, linux-ext4@vger.kernel.org

On Wednesday, February 20, 2019 6:05:07 AM IST Eric Biggers wrote:
> On Mon, Feb 18, 2019 at 03:34:31PM +0530, Chandan Rajendra wrote:
> > readpage() implmentations zero out part of the page-cache page mapping a
> > file hole. This commit adds a call back to "struct fsverity_operations"
> > which readpage() can invoke to verify the file hole.
> 
> I don't see why this is needed.  Since now CONFIG_FS_VERITY will be a bool,
> can't you just call fsverity_verify_hole() directly?

Yes, I will drop this patch and replace the call back invocation (provided in
the next patch) with a call to fsverity_check_hole().

-- 
chandan
