Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B074DCD8CB2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NEeijFWtrK1tsX4O4RB8YArDgAjsTNu/Sz+mG9GNe4c=; b=bl9R1GEFOZeQZl/aY70Gvz/YXB
	ZhbDfFdunEPn9DPCxLI5t3AmukC9CVa9U+swhrHtpXbbyShbIfmoCqalvVmA/Y0PFQAgjvj/TYlGK
	N3qAlL+HdY7vvTtsBuqLXQZSZAA/t6sjohmAGifkGb5okO+pn2NgCboCdxX6p7fqWPEQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wXK44-0004MK-85;
	Wed, 10 Jun 2026 14:37:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wXK42-0004ME-F5
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 14:37:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F1+YOu1BnrsSirsX3jkKI3Fi36Vcnyy+9NfJLa+Vbcg=; b=PpwoPaKUcZLIIaGNcuXC2BXQtL
 2RDtJRyxZPheyF76tnnR1RsagiKt2A4UD22jGbH2cnZtQvL1yTRAWyv3JgNRvABMlkwkvLHQyXem0
 9QJvZ2/PbQDt7IaGn4vmSVaLNZMUpj9sYTmtcGKxxfc8/al+ZPZDqSTxIA0qFpmCWSM0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=F1+YOu1BnrsSirsX3jkKI3Fi36Vcnyy+9NfJLa+Vbcg=; b=h
 pHCkTJqs0dforxloNYBjpio/zjcDUUzOBybnKSf+J/eX8PGaIuOb2OfwJtcZ0xkOQFZEHwX3H1rvj
 EAjdaoUcWJbJaPzjF+n5acE0b7CxzjMRM8HoXBvQjBWge3/OYh5jtDQdjQiwc5krwjVO4O8KF1Jb5
 p6MKl+3eXsHSUjPs=;
Received: from mail-pl1-f176.google.com ([209.85.214.176])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXK3v-000538-9d for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 14:37:51 +0000
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2c0c2a68d01so46208395ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 10 Jun 2026 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102262; x=1781707062; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F1+YOu1BnrsSirsX3jkKI3Fi36Vcnyy+9NfJLa+Vbcg=;
 b=m3yNfCT3m6XDVBmcR8sXae4NxeuPg66PaSRErrCoLcsAGBM0kUnjkp2ruwJPcihxVF
 umJ4n83t6ei8KFoihwO9jUxW1vdbMh3kfnvdhxO+dhSAr5SfRlMPZnYfwZvrSPn+R9sC
 xMo5K2EOthhe6NxHcW+o6O2oNXzDi/SjEEh+QFtxPALtJ9/ZCvXoPG0dk1Ti0+vh8+nH
 wclsn+qicNgLLrNrCHS1Xa5YsC7Hdedcryz2x1Ymx0/R+0Yds47+OqvXlhFtgmbrujVF
 xMosnn6OLp4b9XK5BneTwIoqiX+5AOBwBOORSd+sSU06GbgSLDgAfjT9Gfjs+3gc9aay
 9nYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102262; x=1781707062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1+YOu1BnrsSirsX3jkKI3Fi36Vcnyy+9NfJLa+Vbcg=;
 b=jiTghGWd7XDj5nvo1Sytb/3puk1vQMWUUJX+jT7KuvGupa+uPOV0PooROAe5Qk0WIB
 RAyZh5mqEwQrDepQUdX23HuqmAoJxA/2SgbWZHkUcnbnwoQIoTtLJbfHSeDVCLeI/MNF
 jeSgqE3HVv2afMMoCKHpMRUZyACDfJvtMzHoISbL3Mp8UKYB5vJonEZEMSsP2dskxbLt
 v2VtFi0k5CqxH2wipZTTWRJJZbnVERSm5sqx4gGLnQ/kmikoOFmpzcFOiEC9ir1+Gy9e
 Pv5X1HA4qd/3Q/HNaxEIUoMQJazRMwj8JrwfQu6ou2SfTM3i7baiuUu7EwueobbASkmE
 ym3Q==
X-Gm-Message-State: AOJu0Yz9Z9EegtHLGMLxoJkWxUwNg6XmK5spMEr/+4xwEMZPgfAgE5Ml
 ZJI4lSW4Jg1SiVwmQ3KzCnKtScGISZdiFrRHz1M6VzbBJnSK5QXrTzD/NwdCtOF3
X-Gm-Gg: Acq92OGKf21YLAKEP1w7s9G7GIX7O3qIj0CdacUs2Ivi2qmTuE2U83mtSxvw2M2FUj3
 HnUhWHH4fpw/nBtUnSBepT/06Cy0VUghAQTrXwG4ilirXKE9kHJ2QhHdEebR7mKHhV3gK2rgfih
 xHixoHDp+6VeEn8UHi6915+lLrrlZypMTJRdNO1V3es7NftKSWq3kZEC38lRWjPj5yP8X1UOPtU
 kEWr9eI15CKqH+iL9SscpJ9XJ4gr2yzIb64VClNGwET8Ss9rnO0KBCr9Ebyfylq30Yn509ezAFY
 sx2xovVBYLx7rlYttl8lynMMbDgN2j3gI9TbJpNjYDsj1d4eWMixWphgMLdN8p0zkqqR7LYutnK
 I4OunMtzQ7S4MHhwy2fkbCcpotEI6J/Nw7GOOORXOdtEoKtqZ41qKF0c2vKaRD9jHE/66Ot+NDx
 Xhw5XkXe0XoJZFgVdhG5hD//0yvRSQ9NCDT3rCMyMrhSNqz4ijVzJRcFC0yVuBkvz4OsDppzHJu
 xEEm1Uv
X-Received: by 2002:a17:902:f24d:b0:2c0:d9b7:b7b0 with SMTP id
 d9443c01a7336-2c1e8220afbmr192932305ad.31.1781102261947; 
 Wed, 10 Jun 2026 07:37:41 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16609e636sm250540465ad.51.2026.06.10.07.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 07:37:41 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed, 10 Jun 2026 22:37:35 +0800
Message-ID: <20260610143735.3169935-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wXK3v-000538-9d
Subject: [f2fs-dev] [PATCH v2] f2fs: reject setattr size changes on large
 folio files
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

F2FS large folios are only enabled for immutable non-compressed files.
Writable open and writable mmap reject such mappings, but truncate(2)
through f2fs_setattr() misses the same guard.

If FS_IMMUTABLE_FL is cleared while the inode is still cached, the mapping
can keep large-folio support and ATTR_SIZE can change i_size. Reject size
changes in that state.

Fixes: 05e65c14ea59 ("f2fs: support large folio for immutable non-compressed case")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Changes in v2:
- Drop the obsolete user.fadvise/chmod part and keep only the ATTR_SIZE fix.

Tested with QEMU by clearing immutable on a cached large-folio file and
checking that truncate(2) now fails with EOPNOTSUPP.

 fs/f2fs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6edf0105dbc8..80a64f0ff9d6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1098,6 +1098,8 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		return -EPERM;
 
 	if ((attr->ia_valid & ATTR_SIZE)) {
+		if (mapping_large_folio_support(inode->i_mapping))
+			return -EOPNOTSUPP;
 		if (!f2fs_is_compress_backend_ready(inode) ||
 				IS_DEVICE_ALIASING(inode))
 			return -EOPNOTSUPP;
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
