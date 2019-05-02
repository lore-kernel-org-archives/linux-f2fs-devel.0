From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: Re: [PATCH 01/13] fscrypt: simplify bounce page handling
Date: Thu, 02 May 2019 20:40:34 +0530
Message-ID: <3273903.Njs8gtEjer@localhost.localdomain>
References: <20190501224515.43059-1-ebiggers@kernel.org>
 <20190501224515.43059-2-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1hMDLL-0006Ix-H3
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 May 2019 15:09:51 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hMDLJ-005KTS-UD
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 May 2019 15:09:51 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x42F7blx010592
 for <linux-f2fs-devel@lists.sourceforge.net>; Thu, 2 May 2019 11:09:44 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2s81chn2ak-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Thu, 02 May 2019 11:09:43 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Thu, 2 May 2019 16:09:41 +0100
In-Reply-To: <20190501224515.43059-2-ebiggers@kernel.org>
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
Cc: linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org, linux-mtd@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net

On Thursday, May 2, 2019 4:15:03 AM IST Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Currently, bounce page handling for writes to encrypted files is
> unnecessarily complicated.  A fscrypt_ctx is allocated along with each
> bounce page, page_private(bounce_page) points to this fscrypt_ctx, and
> fscrypt_ctx::w::control_page points to the original pagecache page.
> 
> However, because writes don't use the fscrypt_ctx for anything else,
> there's no reason why page_private(bounce_page) can't just point to the
> original pagecache page directly.
> 
> Therefore, this patch makes this change.  In the process, it also cleans
> up the API exposed to filesystems that allows testing whether a page is
> a bounce page, getting the pagecache page from a bounce page, and
> freeing a bounce page.

Looks good to me,

Reviewed-by: Chandan Rajendra <chandan@linux.ibm.com>

-- 
chandan
