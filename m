From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: Re: [PATCH 03/13] fscrypt: rename
 fscrypt_do_page_crypto() to fscrypt_crypt_block()
Date: Thu, 02 May 2019 21:13:47 +0530
Message-ID: <3498805.PsyZfXou4z@localhost.localdomain>
References: <20190501224515.43059-1-ebiggers@kernel.org>
 <20190501224515.43059-4-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1hMNBC-0005hk-UV
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 May 2019 01:40:02 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hMNBB-003Jt6-3a
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 May 2019 01:40:02 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x431ab8L082571
 for <linux-f2fs-devel@lists.sourceforge.net>; Thu, 2 May 2019 21:39:54 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2s8aj2jr0x-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Thu, 02 May 2019 21:39:54 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Fri, 3 May 2019 02:39:52 +0100
In-Reply-To: <20190501224515.43059-4-ebiggers@kernel.org>
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

On Thursday, May 2, 2019 4:15:05 AM IST Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> fscrypt_do_page_crypto() only does a single encryption or decryption
> operation, with a single logical block number (single IV).  So it
> actually operates on a filesystem block, not a "page" per se.  To
> reflect this, rename it to fscrypt_crypt_block().
>

Looks good to me,

Reviewed-by: Chandan Rajendra <chandan@linux.ibm.com>

-- 
chandan
