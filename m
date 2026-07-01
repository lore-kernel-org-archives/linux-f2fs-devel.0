Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10434C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Jul 2026 00:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dwa5/FHApiPwAxaEkmaQMS316phy1fuoTlvp0J28v0Y=; b=RP0EQzJJaZJKaEukbFKSIDWnpK
	CBarP+tHwDjc6teGY3tK31C24TA28Q6/iUebX4Xc3qDXe1rrpARrZIUOH5fv8cpaEYBfxy08RS0YE
	JjunrUHUHqMsWFAsIXrsfYgEN5Yi/I3mM+9B1AbvNPAaN2xyf0NUxFY3beyNa2KZNWRA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1weiYj-0002Gt-Tr;
	Wed, 01 Jul 2026 00:12:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <joannelkoong@gmail.com>) id 1weiYi-0002Gk-Ai
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 00:12:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EpaEcwn47Z6dq29I8xpdWLntonO2yCBkGdkKIRYVLBU=; b=KAyxIYXqVv6AT3WnNyOphpmQVG
 kHQXOghLE52UNLN7sz3o0j6h23m89TUGPUU8BPvJY41kk6ZDZ9DqqG8rsF6FzXfNTnWj+xoGdSeHJ
 MUJsqHo1fP8Qf9U6BDQ1OgzBXO0G8r7b1E8yuLFhRpSJno0dk4Kgm4uLnDg8yjAp4N2g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EpaEcwn47Z6dq29I8xpdWLntonO2yCBkGdkKIRYVLBU=; b=V1ivNRcuWtVynjok8QNkYXkO/G
 p28F3Y+vNCMNoI4OKG1WHLZwPzYy+d5RG7bJuNEaHd67okGcoS1Cbl+TTJBQbBKugdUS6QQUOaKFi
 HlhQ8N+8B0MHH+Cj+KNtzF0vPsvb5tc6gI1nPfHo05GvOF/jZ/R2ErEbNNq9wkoveEhY=;
Received: from mail-ot1-f54.google.com ([209.85.210.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weiYi-0003By-59 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 00:12:08 +0000
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7e9ef94c0e2so56745a34.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 30 Jun 2026 17:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782864718; x=1783469518; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EpaEcwn47Z6dq29I8xpdWLntonO2yCBkGdkKIRYVLBU=;
 b=Pstto26oT3kxlwb/RNr/hvquGMiJBSqfnguR3o4oslNlDW7fT5z5hYxQpDyqQrE+G0
 4yBq6Ol7mOYe5jvexOl9wlbM55c3R27lijPZxS9aig0VZb7TZ5IxHiCC4eyrtK1fm8l3
 QjrFKgYvha7Yu+Jahz2wp53/6i2ZEsz62+N5X6+aazP6MwWfsnsfCXXF7v80atMGhJ5Q
 aElRcFmU5B5LZJQeeRs+TezZGoHyhC3fuoTpzyQN60rhaq9cm6kv+MSDnb5/KXKJUXvI
 D76c7I5/WRUAhBHIGB0FPgGxCyzy2EUWt889EJkXWuxTDwcuMigEuRfzg8kRu/CZiiXs
 bbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782864718; x=1783469518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EpaEcwn47Z6dq29I8xpdWLntonO2yCBkGdkKIRYVLBU=;
 b=ATaoIlpihf+WM3luw28LJ78thyyI2dE/2hH2WvJKl26EfO9pWhB22y2LdUdx5lxVQD
 T8REPZaRC7htjcCClGaQBj5o3IG5deFzzdAosfoUMkL4q4ETHGWweT3CYJV5ozIfRZEj
 d/VEWB1SBJg2tZo2F1zMEjpNAoLCA+1VH7+5Sa5Ku2AKvtGEGHSHaBXXX1KKloVjtgR6
 RTbHivQo4ZsZ5aLfjErrK9fhZNd0e5h3oYHuR4PU0L251lXNZy5pAPZnFUKOpzpqElcU
 2mBVyjSbJOq6b69MFbDH+BiLAN3E6yxSKFPJX+MZ7zfsFSCpwicf3zs9trOlS1+uMa4U
 CHFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/iRXTAXOKM+/ZscKocw6Uf0K27E8L3HSzpDRGYaK31cvuj4BqQx+yDb99ZlEtGX/WeLmu0x/yMh8bBzYhNZOe4@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yywdx4NZZ3mOB+4dEnviDNED4CIJYo/0/lhzgn01GqBhI50nqJX
 sBVILdYQYeWE6bt0U7KJCLnfXjAa3ilrgFi3NMtEJSEhEz0Sme8MpM+F
X-Gm-Gg: AfdE7cnNnc0mHiwO+4ii0+6Ldm0CwvNnhr+OqLdYJ65CNumb9qLWz0TLm644Y60Ntyk
 C+wi9TJy+laL9+Xb8wgQLQzVyGhj1iGI5/UjxVMqtRqyAIZWBFpROPkFqsQL//ZEzlkS4Nuo5au
 vcvI1eTGhG0Ff3xEuCjo80DFgDLwHsXHoEXihw+ExBggXfxWoe3xYV/y7xyNkGCMeT3Dr9JdsdW
 shNPXi1GgR8nWoSmRO5aGj/ZI8BxVliDqmj+rQ/fctb1ce/1bj9Ua2amChoYf6DNh3bv+dqAi+1
 gInkV1sS9Vz8gBpdPOVpRl0G0b7opH+NNGJe5yF77I3DlbjjGEAVP5Yvo0OntmuV5oj/iD7jYED
 7Lf6Qd8cf0wfzyRII+T811/ZV/SCV4y2p0S/HLmP9UMqKNCIu+vZgBt9/OXkOBWGRt3sMOlVxTr
 CBjNK2Pn44F88eLevPcRo0RKW9r94a+5qSaOpVYMvidAYh9hg5ljS+MKDQT8b5rfw=
X-Received: by 2002:a05:6830:6814:b0:7e6:e022:4b44 with SMTP id
 46e09a7af769-7e9ec6e04c8mr4644649a34.15.1782864717979; 
 Tue, 30 Jun 2026 17:11:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eaf495e0c7sm145938a34.13.2026.06.30.17.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 17:11:57 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de
Date: Tue, 30 Jun 2026 17:09:26 -0700
Message-ID: <20260701000949.1666714-12-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260701000949.1666714-1-joannelkoong@gmail.com>
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1weiYi-0003By-59
Subject: [f2fs-dev] [PATCH v2 11/18] f2fs: convert iomap ops to
 ->iomap_next()
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
Cc: djwong@kernel.org, open list <linux-kernel@vger.kernel.org>,
 willy@infradead.org,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 linux-xfs@vger.kernel.org, hsiangkao@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Convert f2fs iomap_ops to the new ->iomap_next() callback. This uses the
iomap_process() helper, which finishes the previous mapping if needed
and produces the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/f2fs/data.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a765fda71536..afc9b2adaa98 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4653,6 +4653,12 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static int f2fs_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
+			   struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, f2fs_iomap_begin, NULL);
+}
+
 const struct iomap_ops f2fs_iomap_ops = {
-	.iomap_begin	= f2fs_iomap_begin,
+	.iomap_next	= f2fs_iomap_next,
 };
-- 
2.52.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
