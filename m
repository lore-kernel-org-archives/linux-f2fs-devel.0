Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62788CD6E57
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  3 Jun 2026 16:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gEYrIEmwW4xsQuAjNE7ic0ceT0b8Dz9+vNPNeOMmbJk=; b=ZV+WKt8Td/7kwvzOREA6IEEK8a
	6ZmLFUdxYjj8lsBpZ85lbJGNnfpwCCc7Lrdh/AJGbG+vbNw0M4i97ATxvMKbBvID5kk5dXoX1uZd5
	w4q+8nZbKoTma56URA5G/4qQOFDXIVq40UgPzCFvRqcWpVql7CjJsybyWQHuuU7vf54k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wUoC5-0003rw-49;
	Wed, 03 Jun 2026 16:11:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sam.moelius@trailofbits.com>) id 1wUoC3-0003ro-Mm
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Jun 2026 16:11:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xNqB2JQWYAKjwg81Phk/lsiaycyc8892EHyx2k8tINw=; b=WigV0tuj7jnOaKB4Fs9IQOEkyZ
 g0VStvknJNFFCoWk0AvpFV/tj6AvqbF4wNmjWcNdSTIeOGf6uN8stuvcZp+gNL3qDsvD1LNJJwICM
 xfn+OptjToG5ocxkhYVjJLY1pcdJkeNu2UCA8/bpR9q6340D/UijY+7bSLWKyS+7FaAw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xNqB2JQWYAKjwg81Phk/lsiaycyc8892EHyx2k8tINw=; b=I
 qhk8vuHaK0TTXFrL8enHfrfGoV1AvDDPT3L5sYM5TnwqOREKn1/L1j7/qzmmFUG8XmLp61fYtuuMH
 YBpFeaNFu1XSp9ojJwkeeAi+XHuolxDQrsyi22QNDrLEPPtv6bSiNlgeztt1KHwR9Jy8c/EDDVVKe
 H8rICy2uy3r2n2rQ=;
Received: from mail-qv1-f41.google.com ([209.85.219.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wUoBw-0002K1-Qr for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Jun 2026 16:11:45 +0000
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-8ccf0fa0aacso72095526d6.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 03 Jun 2026 09:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1780503090; x=1781107890;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xNqB2JQWYAKjwg81Phk/lsiaycyc8892EHyx2k8tINw=;
 b=AaSU44bjbLCvdTWd0ugNeEOUhTlIUmvW1O5ZVFjtn7mDCThvg/HHfLe61AjIZSeE24
 nIg0tS+UyYZJL7bNMDelSCUCyF+jmZLWgtX5tt7U00M8xaqiBsvEbTUuW7/249vJARPm
 tnLY2Vm1fu/UGV9iGoXNxjOzgo+WmO3cyXeqYsOCTVbI2Ys5opvh0uVISiX7ulflnKtG
 MY6NvpjGEX1MhW9R8eVLph8NhLsbjLhgsJyk4GFY7/nIpS6etA7DhGoyiYx/LmrAsnBj
 sNJx9w30ddZk7LNg3R1Eyku83LADbRGXFLL5tCPCWm3sWvD83bPVuE6XJe4xq4GSIJNT
 V2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780503090; x=1781107890;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xNqB2JQWYAKjwg81Phk/lsiaycyc8892EHyx2k8tINw=;
 b=asuclP67u9k3HqiVC32HTPpx9kpD0oSlibZdauH3lhi/7m1XyromUrePj1S1hSieQZ
 Juy+7fXcOFCjBw8Trt1oshU3aYpZnNiBpI2HkoUZ7W57683N6sdN/yrbhHfwdU5fmHFN
 amLKlWBiPKUMTx9f3MBrToFrQ38WOdNPpdeYTfw6jgh8SoSZddg6ra4LeMAogKul8Mxy
 6yA/Z7lFxd3FmRMj7rG7OtocXbMx60a2dKD/wZB9gHpX5sAscozb9HrJ3oX4LP2SMgT9
 OLUb+OJOZEYvHqR8v/eSvnbN4nojs29HQ/XRj+Lkr1j69+v/9WDY0Cgn5+p3xmlkUZXr
 vL4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9b6vo0x/riiD8VFxnafmyyfDeciotCP/8tsszEo1jftWgT8yJqFSOwQLvJxMow/7qY91becEvgT3Tq/BTOketP@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxpCthGvxSmDGL0NNgtiOnf1s5yDF/p7NluYGVHrh8ezULLB/fL
 m12NNnkGBGpFIn62AKYYL00g4YZUiAq5S6YvY4EmJAMEkZ9t0isR+D2LreGJMuaPqPIzW5bNuY2
 xvJ5KRVE=
X-Gm-Gg: Acq92OHTkwr3lL+NaWGhED+iflz0MRClv8Y6T505oNjknoTpNCZXWDCTirs8hmQW2KJ
 JQl126wjGIIBPxWeeDrz2TJCzJH73B8MVvFx9L63TqlJlRwLfYLxsL4h4C3a14k8brB0h8fReU+
 KS0TzDZkIcHu1dDeBHah9V/dD/LNvIXli4AR8fAcuzgb5teoEE92rXjp8iKOJAkLKrAYGgUZjRB
 5aHbNZlSZP4Scomn0EgcAXTnryuJLkMtcHRPSiltlm4XB2iYrLexXhw6k7DmmqFGKNRrtwwsOKl
 LFmA1KfUH6SONpD4bjWZVKQP+v1ugJM0mcob4o703bNVSWw+D9mHRchja3hZTPb8kSiAKKSxBva
 TrGkP5pBccDbB8TG0zc1voMmXZwEakKkRQxhmbAAbyLn4XdlqwhF4998DLbb4h+VXD6/JRbBS2F
 cVoNvZo1DKyyYQmwqT8OSRVB+htxgjuXYUkSUPzg==
X-Received: by 2002:ad4:5c68:0:b0:8ce:9ecf:e92c with SMTP id
 6a1803df08f44-8cecded8622mr58787436d6.15.1780503090189; 
 Wed, 03 Jun 2026 09:11:30 -0700 (PDT)
Received: from localhost ([161.35.96.86]) by smtp.gmail.com with UTF8SMTPSA id
 6a1803df08f44-8ceccdcc968sm25080086d6.22.2026.06.03.09.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 09:11:29 -0700 (PDT)
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Wed,  3 Jun 2026 16:11:26 +0000
Message-ID: <20260603161127.17464-1-sam.moelius@trailofbits.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wUoBw-0002K1-Qr
Subject: [f2fs-dev] [PATCH] f2fs: validate dentry name length before lookup
 compares it
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

The f2fs dentry lookup path can use the on-disk name length before
checking that the name fits in the dentry filename area.  A corrupted
dentry can then make lookup read beyond the filename slots.

The bounds check needs to happen before any comparison that consumes
the name length from disk.

Reject dentries with invalid name lengths before comparing their names.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 fs/f2fs/dir.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 38802ee2e40d..14161d5a1af0 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -249,6 +249,11 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
 			continue;
 		}
 
+		if (unlikely(le16_to_cpu(de->name_len) > F2FS_NAME_LEN ||
+			     bit_pos + GET_DENTRY_SLOTS(le16_to_cpu(de->name_len)) >
+			     d->max))
+			return ERR_PTR(-EFSCORRUPTED);
+
 		if (!use_hash || de->hash_code == fname->hash) {
 			res = f2fs_match_name(d->inode, fname,
 					      d->filename[bit_pos],
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
