Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42324CD6E57
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EUm9nsG0soJUMeWxhHGCrz+Uw6tl0yUyU1gKAVy1d78=; b=LhyISBvOXPS5Wd0R5kpDeOHEiE
	SjUMF7jABp5pjRhyukpjjtKrPNt66BjGh/ZcQ64DQwqjlFcuv9kttyKPQMaOTFZmldbx7jBvB15SU
	ZGM6eeMiRzyZUQ7XRilftCjCxZS/e9f1khTVfW1uilI/FFVWYDUGO4DPm1qvhxUxhLSI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wUnr5-0002by-S2;
	Wed, 03 Jun 2026 15:50:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sam.moelius@trailofbits.com>) id 1wUnqq-0002ak-9t
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Jun 2026 15:49:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q7Bnzm+zoUq1PmybAub5hEImADXF9AGqvVXRPxWBhyo=; b=Ck4M2/63npYyzr8QOP4rI+2DG7
 bvXcv22Fg9U5BGgXPfzCpCJlZ2qWzAiFx8Q6VtMbq7PTmoh15OxdL80/BTbzitkZ7zTR+XbQ59vb+
 UwrLomkWXgv1QgGP+VcaDslZzLoPcziILlXkHURZMBRPXXVm/N+sXhkUfKmXr68Z8suY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Q7Bnzm+zoUq1PmybAub5hEImADXF9AGqvVXRPxWBhyo=; b=E
 IUoCZfbM+7RdASffIsJ4Vr7ThXhHLVC9j9gN76efzfFOhDw+AF/BWjRfE9W059y3HlzXDHu/7nFL7
 m66UF8BFldhs+GRb9Cc2wtIxFi6+9Xkx/xrgX7QMQsZgMY4uWEochadspuxvp7vpfcnZKbN1vrrFN
 ar/8daIZtNzB5XIY=;
Received: from mail-qv1-f52.google.com ([209.85.219.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wUnql-0008Hz-Hp for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Jun 2026 15:49:48 +0000
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-8ccda0ac4fcso72559106d6.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 03 Jun 2026 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1780501776; x=1781106576;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q7Bnzm+zoUq1PmybAub5hEImADXF9AGqvVXRPxWBhyo=;
 b=NmaHN/wQsrW/axvWVrAZtzp9opNkhvrkjrxiZDxmRcIC+jedEAgHlEymEg9GW5Hcvp
 rUYDrpE7N2wKEOY9R8ncoKFvET+8ukR2D89vldjY2GtRzLO9fCIHDMIFj5MZO/SwCHfN
 KZdFF4Q1FSpQVKpHZxckGKYStMtui2HTLBoHl97GTaIw5cAEE7L/0vHq3BqpWHCeEjtm
 h5gDR+5IS5RZOWATntreCDEWY2+75y3Dz7ZzOoarbnzou7x2DawbPO4aZrapcZwwuEML
 VPk1LoCyToq6FqE8nUsfyM74mjJg2BKXRZ+nGzB9lbYqlJv91CQ8WzkTsTh+NDEOtEEE
 U1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780501776; x=1781106576;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7Bnzm+zoUq1PmybAub5hEImADXF9AGqvVXRPxWBhyo=;
 b=Ag1umxKhs+menZl2LvZQjjQSLKE9Xndudlgnf6eKn0WZ4cG3A0raCwhG7HVXg3ahLR
 GBimvHMYv674MdBIxyU0ZcMQYb4jsuqKZGivUDXi4zmZfkCHezWLkfj0gNoN42bEelgo
 bQ/a0mVhvU/s1aEeCc02GeciNuDU85U/y3oShy4DAe52Zi41pdspOfxUsxvPBYes76kl
 k48wC6z2AE99r9mIqnEqw+Jx3N1exbqoLFNwaZRq6WY+DqQ5BQqRDDCe7wlbbM3G4bH/
 1moL7/WH3FruNkTOyCIS8X9oDFXTYIxQ2X/VB1VTVwAzOt1VaIuEVQkq/TFPFCGlyVmn
 Egbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ81pXoNaNT4wLM+QlPxJccuQq0ajmD72n36aVLZ7lPEiWaPlK7e5TPRoVFjb6Ej8IxMGbX+Mcn8PShQYhY8CL7q@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwOspBMrtM+KCFyx0lAB4PlNdGnKU+dVzPebrM4PYnUCd/d4tPs
 /u5DeG/GNf+ChoVTuoV7eB9v1XIMC4Vr1hro12d8QWydX5TfwH8qbF14QNcEcQn738lzsjT6rTG
 LE7Ty2tc=
X-Gm-Gg: Acq92OEHY3IMELzm+Jb4DNYF9yWWrqZxyF9kdmnPGI8vfJJs6l0IfDQakoLWVhDMwoY
 ZPVzojuQzATAL3rtlrkWNt38weVVttMuP2tJcC510o+gAH5hnLidMjH7Ka+Yc5cIc7IEVEUuKj0
 Rv9E3Q5kiZ/SS/GHQNl6NIxNVuE369N5gfxp/uunj7Cddx+LSAFee1XtW8OiE1GDJ8cLCbfOpMk
 vu5p1U3KVnBZoCqbfT1VWPOkSjvhoTdRnTWEQUjF4q8gsIo3tSRTYLNpFGBqNj67q81pZgWWit8
 c370swN6FBAyMWCRO8h5Bfq4QT3vq/SvJULHLqkGGfpdb+TtP8ejaGhtPB+R+cRF+lc5RbaKXSB
 nce01i/9egbWAQfVgtSiNdNtq4706TZNEuJQCtTR5uzC74IyPzaMzSl5lZQuIdGjuigwGBDybQG
 rqRsCXeGF856lxm6nPWGpEVCdGnMNl9RzeA99eZQ==
X-Received: by 2002:a05:6214:4302:b0:8cc:f899:bb79 with SMTP id
 6a1803df08f44-8cece16246cmr54331596d6.46.1780501776353; 
 Wed, 03 Jun 2026 08:49:36 -0700 (PDT)
Received: from localhost ([161.35.96.86]) by smtp.gmail.com with UTF8SMTPSA id
 6a1803df08f44-8cecd055181sm23176366d6.30.2026.06.03.08.49.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 08:49:35 -0700 (PDT)
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Wed,  3 Jun 2026 15:49:32 +0000
Message-ID: <20260603154933.16368-1-sam.moelius@trailofbits.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wUnql-0008Hz-Hp
Subject: [f2fs-dev] [PATCH] f2fs: validate inline dentry name lengths before
 conversion
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
From: Samuel Moelius via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: open list <linux-kernel@vger.kernel.org>,
 Samuel Moelius <sam.moelius@trailofbits.com>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Inline dentry conversion copies names out of the inline dentry area
before checking that each recorded name length fits in the available
filename slots.

A corrupted image can therefore make the conversion path read past
the inline filename storage while building the regular dentry block.

Validate each inline dentry name length against the inline filename
area before copying it.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 fs/f2fs/inline.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 7aabfc9b43cb..4584dfbe3fb8 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -507,6 +507,10 @@ static int f2fs_add_inline_entries(struct inode *dir, void *inline_dentry)
 			bit_pos++;
 			continue;
 		}
+		if (unlikely(le16_to_cpu(de->name_len) > F2FS_NAME_LEN ||
+			     bit_pos + GET_DENTRY_SLOTS(le16_to_cpu(de->name_len)) >
+			     d.max))
+			return -EFSCORRUPTED;
 
 		/*
 		 * We only need the disk_name and hash to move the dentry.
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
