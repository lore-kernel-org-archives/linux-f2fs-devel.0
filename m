Return-Path: <SRS0=actn=GI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7D8C433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  5 Jan 2021 00:55:47 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8F1227C3;
	Tue,  5 Jan 2021 00:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8F1227C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kwadW-0001bK-Pw; Tue, 05 Jan 2021 00:55:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kwadV-0001b6-2H
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Jan 2021 00:55:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v2kfiM4zm8BOd9kShD7CjV3ajdHNBCeiD0n6gOiZcug=; b=ALlMQCjI/Bow7SQALIM6aAaA72
 RinOIIK/oD213CuVwCOWiJllrrHTtZZuJFf3XsCqsFc+Jkp1D5zh3q3hFNCy1nee7W/w52FE6H8uQ
 y+JTyR5fXFe/a6Dy0UPgaWskbYoGKMeFPrinYkXt/OIEny0pev2FpfK8I30NIgZ5nAtE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=v2kfiM4zm8BOd9kShD7CjV3ajdHNBCeiD0n6gOiZcug=; b=aTfXi+eLfTK3g0H2ysbgi25khg
 2mEMIqt8DBVS3brlUCdfkOOy8mROOxrGoU7xRFCBYyPWNLC+Vqvaad66MFhXgjJzdaaK86NX/Svp8
 Tu+NIIGsRN614iUasVd7HaiS8wpD05t7VQrGrUzWD7KFq38HRGknWm1AFnG+i3Pes7cw=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kwadR-00E0Rx-RW
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Jan 2021 00:55:44 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F647227BF;
 Tue,  5 Jan 2021 00:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609808110;
 bh=gNmDYe2Lw3Moz7fSm4TY9dr/5OhIQas+i4KMcztjpdA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Iue5bgzUAw8lnkQhxntcvGe1ceXoW5GSJWYIHh3cLSi/unfeetrDIk3AEiLSYzXXM
 YRQ0yms8cM/fhbIoNhu2BFHmIxs1KHKry2eno50f0+As0LpEMAFdE2jzEK6/I+t79x
 q1xCXE9vM0AMyX4uOGz6HuPfUF9wxnuqjDGTfduCP/T8y+CI8WNZF+C6o8JGDmDuRb
 6XujVxKjL7yeDT5YHWoAHOi3U46i46aTw1Z6B/hNUFzMJq+9EuadYpNdInK2x1Ora2
 NDZjswrQjIOKf9F0DW31SasqoFVgS7ALAcH8xEZ6GQAEgUhyFzB2AoBeG23brpfA7v
 i9mSTRbrzfsTA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fsdevel@vger.kernel.org
Date: Mon,  4 Jan 2021 16:54:51 -0800
Message-Id: <20210105005452.92521-13-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105005452.92521-1-ebiggers@kernel.org>
References: <20210105005452.92521-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1kwadR-00E0Rx-RW
Subject: [f2fs-dev] [PATCH 12/13] xfs: remove a stale comment from
 xfs_file_aio_write_checks()
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
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

The comment in xfs_file_aio_write_checks() about calling file_modified()
after dropping the ilock doesn't make sense, because the code that
unconditionally acquires and drops the ilock was removed by
commit 467f78992a07 ("xfs: reduce ilock hold times in
xfs_file_aio_write_checks").

Remove this outdated comment.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/xfs/xfs_file.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 5b0f93f738372..4927c6653f15d 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -389,12 +389,6 @@ xfs_file_aio_write_checks(
 	} else
 		spin_unlock(&ip->i_flags_lock);
 
-	/*
-	 * Updating the timestamps will grab the ilock again from
-	 * xfs_fs_dirty_inode, so we have to call it after dropping the
-	 * lock above.  Eventually we should look into a way to avoid
-	 * the pointless lock roundtrip.
-	 */
 	return file_modified(file);
 }
 
-- 
2.30.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
