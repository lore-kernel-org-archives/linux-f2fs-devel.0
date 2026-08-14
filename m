Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBC2C5B572
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=grJedrnMyTKsMbTsnUnZtoGuznZr51zPRLikZI3EZtw=; b=SKFBbk/xLn+Hz/tjJ9clLIx63Q
	3osDA1yDU8GxDZucj2Hb3oaKfTXwO9O4IuZHwgPGkBx+fUPxqT+8rL4sflZlZVmFOVYeX/FqQcmJe
	1TpDnTlQrTaKLjE3Df57636y2DLxpipa36YKzgaI7knC/PPB0d4sF5J6uwdfElmZqPlo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wupXx-00028X-NO;
	Fri, 14 Aug 2026 10:53:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jsjlee1020@gmail.com>) id 1wupXW-00028B-SP
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:53:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uh+z5qK+5hJqxFnzXnj40mnpcN/ipc9PC4qTgpoZZhA=; b=gpBNbJkIYLg07fnikVS7mKjIZx
 CgZXxRV+y1HSNTQs1SdRUXBi6hxcnt2vhJ9Gqeh6EmJA8EZOfOKrC8VJ11Y0zNcVuovHvkGwmycM9
 95nm2aQhrC8dQSUQu7I2FAx7OzsZYa3kXjAU75ODPRep8AoYVqFFLZKCTxUCT5jaXGuo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uh+z5qK+5hJqxFnzXnj40mnpcN/ipc9PC4qTgpoZZhA=; b=Y
 A4fNg0GtyUi0cyCi8Poyf7tTZf0MakSVLqhQSatIKX63L9cuBV1F8J5f+eEEAqZj4t7UCtcJQ0Hr0
 28xpO2h6tfldRtONL0pFdzzwQx87joRiRdIpKN4/ThoA4Dw8IO/HMi2t/RBcdKJGSxRRbZvMrCsJG
 wqH2wSqPNWFblDQ8=;
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wupXX-0003fJ-I1 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:53:28 +0000
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso1148939a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 03:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786704802; x=1787309602; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uh+z5qK+5hJqxFnzXnj40mnpcN/ipc9PC4qTgpoZZhA=;
 b=hU1n9QqgiDPi6t1fzu5fBU5moz+sBrqa2vvwCogK12WrfnRNl8FT9A/z32jVjKQ4Zs
 j9oQuRtxw60pVxxBas4kvoljRcxbt1XJMK9blFmG4BggvqiR5EkwcUa35sPEpApJk1cV
 mrmbPAh6TX9m0tLbEjC5x/PpAY9kjBHziC7pztQmEoIxy+6MWVErSoVoXldHPe9h9sz+
 rLjaWs1KvpJ8pTOBYlkD/U2YencYuI5XfV98itlrYn0AgcgezZb1FW6OHaddSwTO7W/4
 W0IEvcHINv1KAewtDdNNtiVYr3DS3MgTtkcLqo9J5H2jQhQA0/aqfFGx2IRBhOsnl+Kt
 294Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786704802; x=1787309602;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uh+z5qK+5hJqxFnzXnj40mnpcN/ipc9PC4qTgpoZZhA=;
 b=HnZwAEHGzD01ZE7D4lK84ItgrnzEGd7pHa02KDjLGUyd9ipnK0SVzGSzcOm4sFFVby
 XxsUgZJZc3iNdCJ1dJAELXgEfbz62QgU2zvVhrfFGHAcrQrV4E32DU+dRWND2I3GAjlS
 3UqE1uV4zOUd61YnY4ca82oPX3sUWjo/5oqSfjz69Q8DtWsuAZLXMOqiUwmShciHN0Fa
 5w9D01sG7NjY9LwjrWegEs4V+VtP4kyd5+14qhNJ+2JExnNvhKnwkOxe6wfANfDJe/9t
 JcRl3W3kxWJzXq2t0fsOgzPjqV6yYaxeAF0ZE+kGmK6NOkvHHzt6M3iSeGBvElD+yL2b
 92Bg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRILrfaXcot2S+owzU9N5BnRhkk8OWUqpe/HNKwOGWfKhdlAEHrYQI3EWS3rMMUvK1vUDkiDnKuPgPFHuYCnor@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw+Lc76tfU5QtYTsoHUuchEBvt/cv/sGw9YjXOHyQk5wRBOb1Cb
 wX9SLmJd0AkjI0Q/qPhleeb1aGFvY+kdutqoXIvv9+tUaQALBdAFj+l73lpGoZWO
X-Gm-Gg: AR+sD13sL6Mjc8Tw9b6tU/NMxfsBPrXmFOUonEu3ngSR4XYO3Bh/5gpHnw1SoEXJxKL
 Q+3JNzSFUfWt4WdiTy5b/Kp0DFR1i6vOAERYbb8DUJk4FqqleTxyDbr7Q8UX3PojmWr+Se+bVxB
 SakZTpkvSJbEbK2B3RLh2DeRTUkasRTfuD9F0dcF8KiVFNPTpuqn2LNWfP9yCGURFNvM2eV0y/g
 tX0AX7ld63SCI3NagOC+opgGy3GE7qn6RrERaV4g44aJ6tuzqAflLoHCQkMotYvgNm1JWjCqJJ0
 KMT0ExX96Hyh/Wc/WVUqufULo2/+9MpxbTcQWb45MndSQSl1Sa/B0483zUVVDYQIOWZunxoSTGh
 5IX1YDQ6K8Lib/B3Er4DdopIRlPejiGmXzAUgyCA/Gb6rC+tVLSzZMH/GatdHC/xJXc61TypvT0
 dNiiihvVgdKIk9rRA7pYQt8ll9i3whHqi11r5OGzkb+R2S8wzFUnsVdmD+O79EIYtKbfi6hoXkP
 AySGFHRK+RrY3eJf3/P8epV4krt2UnQE2m/gtOgDsRgsoVs5W2VkrLpSdt3QtJo
X-Received: by 2002:a17:90b:134c:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-3933b8721a1mr5379585a91.10.1786704802225; 
 Fri, 14 Aug 2026 03:53:22 -0700 (PDT)
Received: from
 codespaces-2362ac.m2fxbej512jepnsor2itp05j3d.ix.internal.cloudapp.net
 ([207.46.224.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-394eb752fe2sm2305268a91.14.2026.08.14.03.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 03:53:19 -0700 (PDT)
From: Seongjae Jeong <jsjlee1020@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 14 Aug 2026 10:52:34 +0000
Message-ID: <20260814105234.31620-1-jsjlee1020@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Headers-End: 1wupXX-0003fJ-I1
Subject: [f2fs-dev] [PATCH] f2fs: fix O_DIRECT cleanup range for append
 writes
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
Cc: linux-kernel@vger.kernel.org, Seongjae Jeong <jsjlee1020@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When an O_DIRECT write falls back to buffered I/O,
f2fs_flush_buffered_write() uses orig_pos to flush and invalidate
the page cache.

For O_APPEND writes, f2fs_write_checks() updates iocb->ki_pos to
the end of the file after orig_pos has been saved. As a result,
the cleanup range can differ from the actual buffered write range.

Save the write position after f2fs_write_checks() and use it for
the forced buffered I/O cleanup.

Fixes: 92318f20d703 ("f2fs: preserve direct write semantics when buffering is forced")
Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
---
 fs/f2fs/file.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b99d9cdf9ba7..bf61545603e5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5313,6 +5313,7 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	const loff_t pos = iocb->ki_pos;
 	const ssize_t count = iov_iter_count(from);
 	ssize_t ret;
+	loff_t bufio_start_pos;
 
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode)))) {
 		ret = -EIO;
@@ -5343,6 +5344,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ret <= 0)
 		goto out_unlock;
 
+	bufio_start_pos = iocb->ki_pos;
+
 	/* Determine whether we will do a direct write or a buffered write. */
 	dio = f2fs_should_use_dio(inode, iocb, from);
 
@@ -5396,8 +5399,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	 */
 	if (ret > 0 && !dio && (iocb->ki_flags & IOCB_DIRECT))
 		f2fs_flush_buffered_write(iocb->ki_filp->f_mapping,
-					  orig_pos,
-					  orig_pos + ret - 1);
+					  bufio_start_pos,
+					  bufio_start_pos + ret - 1);
 
 	return ret;
 }
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
