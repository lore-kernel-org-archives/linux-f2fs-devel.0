Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C7EC44501
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Jul 2026 06:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Date:To:Message-ID:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yBrP+oN/7FUQpiGuSP5wx2AUbAywF0wbynbAHfvUE1A=; b=O03BDILZcnbu7MY6/zssE8ZZCs
	QFnFLSQGgwIqyCNDZ7VQUwU4iMAByaPUGTqpLAILXfppWfwQYFJGo065HbPg+uh+AfFwFlSNydtVf
	2W9CVWjd+SyeSDhLSxhW/rGwfcmDWVNW34/qq3USiMH43TAqi3CoxF2tozoXsh7aZr+A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wj9l1-0001vw-Oj;
	Mon, 13 Jul 2026 06:03:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <3497809730@qq.com>) id 1wj9ky-0001vo-5h
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 06:03:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject
 :Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fPnUTBnX9rEUlFodo3utzbAQ5Y2INf72HuDM7nHGsLM=; b=Ka0/T3h0apPoRWJ/GulJtU0T2z
 L/n+vSLZyKYcKxlXlIIUhEEo2pPTF7Y8LEiWJsysqTkFPAIumJF7oLUW1qEv+VFtcsZtLkEKrC1Qm
 3/LAHrajIw4H0U9KyGnT2lslloUhaHiWrYpcsXh7hUVQvktDJwpUOdgjy16qpYPRmGhg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Message-ID
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fPnUTBnX9rEUlFodo3utzbAQ5Y2INf72HuDM7nHGsLM=; b=W
 AuZGkQCafDvhAHwe8E7xauzHB46aVbRky4n5h+o6i1j+exXiyNmogwjwqbV13KUelNTdJz1AiNuMh
 91Dpz74M+J/tnL/w/0waWkuwfF5rZNG4CljH2mOsqePFajihoQp+yz+g0UDIBc064mAt6ws5/gz+5
 IysXejMYXe/pb+gk=;
Received: from out203-205-221-209.mail.qq.com ([203.205.221.209])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wj9kx-0001NQ-Vw for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 06:03:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1783922580; bh=fPnUTBnX9rEUlFodo3utzbAQ5Y2INf72HuDM7nHGsLM=;
 h=From:To:Cc:Subject:Date;
 b=uVkf2Jdp5yL72Ed+0WsgqQxoOmKiMJpRpvTJ3RhZVJpEkiMlu6D1GXItgcZM+64IX
 dEGg1gQdwnVC7oJOCbMG4BmEKYUdjjBSQ8eD/nPnjcKvyafPP9o7FoqvKkwwaIi72f
 GSiiPBYrqZRvDG63zFjjWTB9d8KnvUX5NphbISHk=
Received: from ikun ([221.176.157.250])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id A7374EB; Mon, 13 Jul 2026 14:02:39 +0800
X-QQ-mid: xmsmtpt1783922559tbrq6dkau
Message-ID: <tencent_AF84C3AD07E239869DCA86274251CDB33905@qq.com>
X-QQ-XMAILINFO: NVJ0hJNx7N5SXgPSVEYKvnhA1jm6i3a0BfEJEoRmvuWlYtYNoiTmODQhO4/YlG
 DcqAd18pnmdNL7MOyzIgWyapmCOqjmNx0jsxy9S9sJW2nC7ClMG0dDQvUaqI9fzA+rW+WsYoTzm1
 hFDaaVVD3kByE2DnM8LdO2J/ZPPhpVWJhMHyvsE4v6riQur/Ll2HgkpI9yH0Or6cH6wuibpb9lR5
 61/zKYU6PF4c7PFczix9WTNDQmxbutB26yH1Eflkh9Di6K4FoF8fbMxkSpB8RNYlF4+mosUPJTFg
 XJ2pavgdNvUO2bICkdkQUOOxtFz6KQZtuRAIST1jpWJtf+Uq+JDX2EOdUbtFro7ceRSnEB4DZBAb
 L6183O3loblS0+ZnClcblBkn8LMOMgR8D8P2mZc6xS0mFy30lQu1Z/+JGgz15deiNinMw28IoVjW
 7x8+EjQZ4goLLAZGlZQ4ig9GirZkNDIn3aCHHbEZmQUnj+97vAUgCjfYojwh4GqsMh0pU2RM7JM6
 ff/swKvor0QeP4AiZnAKxHve4KwowwkN7z2TCdiuRXiKFH8V1/umwVDg+9+LR0mEIsLnZxBJpLon
 s9sEZZ2qBeEQDN8N0KLtmOWQvusgXQbSeSSqvugRFkVmywb68yuzB5dQMujtM1zVze+fLZk63mKh
 xFNfM45ZM5uMry7RXFjWMHXh+xGjKYzgqDYVZU8Zo6UnqwvAeEq9a/Qi4uQsgIwFMQ4d3A28GMkc
 Nb2DkabSc+4sYyN21q78jOhQWG0FwPI0prWWD2EPGMe/8AKhygNGpm4sJVHf30KkGd9uEVLM1vfB
 6qZLZo0aWv5G/TGwEVe2I/3wj9GhXEsV6zJXncQGmdrtqX1UEFYYvzA2DCaH9QOwVnwug+4nTBxY
 nOoWnjnw1+brezWpC5lH2Lp3prumMsAsI42xzZhhwKpi4Z7VUVFse7aTqwdqnbLTUt0ESo6oxuqc
 Jt+Jiqb15LJqf25mQkyYgS54VOZVmUVOWw5ZDmY+PbpIF5odN486Qr+APFl5NPMWfwpcy8H+POts
 nY0Ifx2EjfAX6PG2bFJZ/54Kho+Bg=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 13 Jul 2026 14:02:37 +0800
X-OQ-MSGID: <20260713060237.548-1-3497809730@qq.com>
X-Mailer: git-send-email 2.52.0.windows.1
MIME-Version: 1.0
X-Headers-End: 1wj9kx-0001NQ-Vw
Subject: [f2fs-dev] [PATCH] f2fs: fix ifolio leak in f2fs_get_new_data_folio
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
From: Guanghui Yang via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Guanghui Yang <3497809730@qq.com>
Cc: Guanghui Yang <3497809730@qq.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_get_new_data_folio() documents that ifolio is only set by
make_empty_dir(), and that ifolio should be released by this function on
any error.

The allocation failure path already follows this rule, but the
f2fs_reserve_block() failure path only drops the newly grabbed folio and
returns the error.  When make_empty_dir() passes a non-NULL ifolio, this
leaves the extra inode folio reference held by the caller.

Release ifolio before returning from the f2fs_reserve_block() failure
path.

Signed-off-by: Guanghui Yang <3497809730@qq.com>
---
 fs/f2fs/data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a765fda71536..e66aefc573d9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1477,6 +1477,7 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
 	err = f2fs_reserve_block(&dn, index);
 	if (err) {
 		f2fs_folio_put(folio, true);
+		f2fs_folio_put(ifolio, true);
 		return ERR_PTR(err);
 	}
 	if (!ifolio)

base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.52.0.windows.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
