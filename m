Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A57F589CD
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ev+kbcpk/t9zkt51glVVgcMjK2BVhxvStsj21hMZSEI=; b=AYJfj3LnnmFOi7CLMM0wuF9tJ8
	ZLII4J5LEF2JXfKZK1QfY2E3vROLXZRJmlqLrytQijPkAPSapgWmQqRDiHlHOCCKwPuQrLYczwtdD
	uuy490yYTKdC81olM0zY7p6Cqq5aSPiVoo64lS4Xjotf3wQ1hv2a83ulw3HxmeHfG6aA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFtra-0003TG-3n;
	Thu, 23 Apr 2026 13:13:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wFtrX-0003Su-Fy
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 13:13:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MIBc7SY/aayk3KV59ElfMlB5cZR+zErVtDKAUR8Qwg0=; b=FTy21FEyswjc4ha5XuI96K6kC8
 DvCnnlnNQjlfDK8dutabLxbEKKJ0DaEJNdbdmUWV9Te3x5VK5ls9z7RzbjEgQFH6PHf3OvV6VfnkA
 tCWPPMoFQLjaKMP/X7WmL2WtnXCGplR0r5hQvHg5/W7Jg65Dd/lIxmMOzvThnqsB4GHU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MIBc7SY/aayk3KV59ElfMlB5cZR+zErVtDKAUR8Qwg0=; b=XitpEd7tMakeVem85YWp0nb8p6
 aYFnDvV15vw3NhZt8FMuxPadjeKzggfXXmXn2GDhV4vbIQ8QkLMjKUn2gv2zMS9ZJdPBmFVrq7pQm
 kuFBdypGvdtAggcAYs6OlJ+7PDf6scwpuzcZhl6r+SvnuYUOLaZqf7c9vpotq9EgmNmU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFtrT-0006pA-5V for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 13:12:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D5B95437E4;
 Thu, 23 Apr 2026 13:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87020C2BCAF;
 Thu, 23 Apr 2026 13:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776949964;
 bh=Q/Z3eU7E7G5VuhyXLGLHVQn/X3HZutM3gSylfnZVEPg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=b5gScez2YED5kR4UfP7ePXzzEJBb5rUkzl2kaWZ8I3PLFUgBLAbDFoL6fUBrKhQsb
 vY7VDji9bHDReQ5D8SfrPb4vl99b0Oo3UsSGYWGGc6n9UsMvzFdSxZSJDss0CoTzxm
 oltz16gygeIH57IBkctp753tNu/+G9aCXfA4LYLnB+fzWUhEYju83IJ+sXU8smvzdP
 o+gArT4pCLP3Z68PxSt9h0Z8PImmccL9/D2lM0DQUcfIGgWnhyzpGjghvJmtKcZ2CS
 2Li5JyuynrqBOkmQMrKRlm0LlfT8IpYZyQRNIRA2/V8vsfwlaqqrWEO3GQQBydWlvP
 pDCsYsSZbsNbw==
Date: Thu, 23 Apr 2026 09:12:12 -0400
MIME-Version: 1.0
Message-Id: <20260423-case-sensitivity-v10-9-c385d674a6cf@oracle.com>
References: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
In-Reply-To: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=f8bPTEa6xHOGMJ4BkwBw/MA1JRSPvJxuTKAc3AxqaEI=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hq080HBIoQoVwdco58yDR8YVIdkIx/l7nWCL
 p17rvkKMhqJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoatAAKCRAzarMzb2Z/
 ly/ED/9AmddXjVCN3aojVl3dq7vYD4dHLpYLDtV64JoEYigKfl8rORJ11NTU+gqKE1e24B60uJk
 pdFiokvjs9qrW2JRbQFgIwW6hTV815teXb8jU9fS7kXCDGUBNNqBMi1AURxGS0+cKMvJOsG7wvl
 yputvf+P5kAEyAepPLwNZDeQ3ZsFw0aB/O7Wo43QmTRdbwp5K86ykLPGRxjf5QHuw2z9nn4q9XZ
 EvfnjgtzDe+CRaFbZFrJD1YflFdVfMzmJ8y8OhJ3VPs7+SCXwRGJqQ4t7WOPHwHRUxId1+yvGLf
 jlpNGlpLScKmAZy0wex1OROguQuASjnDTEND3+Rnxm7dmTYA08JqC8C9yRPit0M62pGj9Y9V162
 sSMrVUnmNayFOLfJuFGyYOD1C8vpsqsOVB6H47ikng+DKH85GPzl26ob1o/KebclsssdTPgwdzq
 +yVZixdIvTd7o/xyqgFffTVmBgYCW6aG0Wx7eB5CQMmPAcy+0BrbsuRaTuWhzqAVS8OgqfF7X8N
 ZVh4zYhE3s/YMsVzb78E+fwRyV7Gs+2vW5BtzPVat9FZxYtahS7k+5fIlWewHB0u/Ps+LzSnUJT
 Hch9406DJ+hMcAznh9G3hlsmcRQPA7MlqUf7my4whGQPZvztR/OETamaDE6BzniYdfmQ2AAjG9L
 zRv4taVhhDcNCMQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wFtrT-0006pA-5V
Subject: [f2fs-dev] [PATCH v10 09/17] xfs: Report case sensitivity in
 fileattr_get
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chuck Lever via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chuck Lever <cel@kernel.org>
Cc: pc@manguebit.org, yuezhang.mo@sony.com, cem@kernel.org,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, sfrench@samba.org, slava@dubeyko.com,
 linux-ext4@vger.kernel.org, linkinjeon@kernel.org, sprasad@microsoft.com,
 frank.li@vivo.com, ronniesahlberg@gmail.com, glaubitz@physik.fu-berlin.de,
 jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp, linux-nfs@vger.kernel.org,
 tytso@mit.edu, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>,
 hansg@kernel.org, anna@kernel.org, linux-fsdevel@vger.kernel.org,
 sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chuck Lever <chuck.lever@oracle.com>

Upper layers such as NFSD need to query whether a filesystem
is case-sensitive. Add FS_XFLAG_CASEFOLD to xfs_ip2xflags()
when the filesystem is formatted with the ASCIICI feature
flag. This serves both FS_IOC_FSGETXATTR (via xfs_fill_fsxattr() in
xfs_fileattr_get()) and XFS_IOC_BULKSTAT (which populates bs_xflags
directly from xfs_ip2xflags()), so bulkstat consumers and per-inode
queries see a consistent view of the filesystem's case-folding
behavior.

XFS always preserves case. XFS is case-sensitive by default, but
supports ASCII case-insensitive lookups when formatted with the
ASCIICI feature flag.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/xfs/libxfs/xfs_inode_util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_inode_util.c b/fs/xfs/libxfs/xfs_inode_util.c
index 551fa51befb6..82be54b6f8d3 100644
--- a/fs/xfs/libxfs/xfs_inode_util.c
+++ b/fs/xfs/libxfs/xfs_inode_util.c
@@ -130,6 +130,8 @@ xfs_ip2xflags(
 
 	if (xfs_inode_has_attr_fork(ip))
 		flags |= FS_XFLAG_HASATTR;
+	if (xfs_has_asciici(ip->i_mount))
+		flags |= FS_XFLAG_CASEFOLD;
 	return flags;
 }
 

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
