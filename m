Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5A0C61DBD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OZZ43Vprij4hy2sv7cf202bNjyxHnZigVS7lUg+BFxc=; b=HBbcb9HwRafNEoUJT1XZ7SXnxo
	WFqI3ZKb8/O2hgqq9k8Q4kq+sOOkyjdbGi81Ds+B4YHAmNkR/SOZdieTaSHVqOebZZr5fKehQqYgB
	b4/cT4p/9sOI15U6/oCvvfVBAOoyR9A0NqRqd5ALA5x9om5RfGcVQ05jb0GbjOydptVc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzH8i-0007HQ-9j;
	Wed, 26 Aug 2026 17:10:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wzH8g-0007HJ-TK
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 17:10:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4qTy9EY05MYgzjfQZXb22+wxLg8mKbw/2dfRx0/rF4c=; b=fwLXB0ovhJgCZVQXRGbEMeLhpU
 1nCzvYr9LX5tuYO/YaZyX1WcASTjvNGRe8PiznAx8m/Ecm+HFjnAkXk6gdWKCHRShj65XQDmgbRJe
 05X4xOF6Bm5g8zC7T0MGrDlnQzLzWbjuNE6BSsJDK8TyqLNhAQU7hpzdUuThzZyN3GmA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4qTy9EY05MYgzjfQZXb22+wxLg8mKbw/2dfRx0/rF4c=; b=NQ+maUK+RAKZnwRez4CO7/GDu5
 7v1VdIeQ/BuEYviCpNDfO2C8YoHB84IpyuJXTsSyen3LpSsd0lISAhhG+k0g1rkiJY1PtqmBwRrRk
 PYulcCz968jJIeB9fh2iZtWkFR1p58nyhA60bSHbA2MY2N1/rgi6pJ8q48VKjUFajZcU=;
Received: from mail-pj1-f45.google.com ([209.85.216.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzH8c-0002YT-6s for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 17:10:12 +0000
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3964dfb5b9aso1642036a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 10:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787764204; x=1788369004; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4qTy9EY05MYgzjfQZXb22+wxLg8mKbw/2dfRx0/rF4c=;
 b=s1t+GcxRUOdqMLzDGdacs2eCjWoMdccq176cHd/ec8N5Zgtmes1fNPNRH/JxFOHPb9
 8k7Gp+M/5Dt7UAmiOUPUqog7cy7EKOPlHyGVQGheHheYYMdhXAS4rY9cCU42hvSEps9E
 ySWIz8hmSrQzlryE3NekrjZPTy3PBTeXV1UpupKg3KeIa/Kl6N+4ov/YFGdsFsMfGhsq
 AW1dDsG9SfBbcGE6FDZ0U1VTinK1/CyYC0nLSCx6pUv9keOa+TyB9AOcigt3VnfJMgDQ
 /1iSj3UyHOPSQGFxjIT35VzD56gH6/uNAB0e8iPou0Ibmo9akKgRAPoK5tKkUhOrft+o
 eAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787764204; x=1788369004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4qTy9EY05MYgzjfQZXb22+wxLg8mKbw/2dfRx0/rF4c=;
 b=sLh59TNAjilOnZ60URC56koqzQLkJfAcUXG19+dwJknXhPwGJgsgr+iPIb5K5+XpLZ
 uuhjBq79lcSZvXhtpsU4vBvzEv7NuIjhW8crcvPQBuQa/bkizhLPaiy9leaz+9FEKwc0
 IrmkU5lbwXyzAZts6TwEYOkUePJ98vnRGJr98K2UEXHcM/5IOkXPeFl4WZCDHjb2zXv0
 oFN4jgYa08qL5h8Eq9Yb5Ifz+cSKS2kON41f4mPNc42LdeDMc9eOESK+vTOvw0Ba21nF
 EwU4BkiyVsSfsFRF1JCBBp77+x9D728aLRRYHkTL2TA9IB5c5jHpMlcpAToGzR0Z4EwU
 OLYg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2UIxBw8WoAfsqIQ2icd7LXPJp2tOSEH8z/Ed7zo8cvTi8FIkIf6z7jXnGlb/sRXu9ntaFhCu2Z5dSLeJLonsY@lists.sourceforge.net
X-Gm-Message-State: AFuF++mYFohTSNwAOb5RUtTISEVvT+juRduoAUcoykDyVciCVbG9q5Iq
 JN+bIK91eMTUysMtNo7i5YbRVd7gOwPzM3b5zWRhiHLBZpt6Bq5fCKBh
X-Gm-Gg: AR+sD12HZOH2Irp4oanisDIVf4Q7ErD5j8Jr30cTy7CdbLk5aJir86TYuuVdGXY2bnY
 sEIk2FpmnzPza5DOTC3UhayTx+KBZwPE/wKrLdblEWv43YUEgbff/SbvP/jA7wSBXlQiQZtl0Tx
 lAl2wUWiB1RTVwSMJSagWylV0sMvx3IjV2TfVgUG1reUzjNZniPienSHITJxqc1exBVhUxUdRim
 vu6moBTEA76jAglFZwQVrlTJK4/R63aVAQMd/ZFGtbSpSU+FqzniZ8r7dv8im7Bwubm1b4pZKV/
 jpL/xe0XvLgvDDykh8hD6AUSA2pD/5zTXlV6YMG+dDYUjhEBu7GxKT9hfdkICjGtGqQyPssw4UL
 XODeO911heYgJpDZITPLtC22rbbGJBPlsPPpEwcIhttbX8UO4cJPNeVM8MMq5aQNsinlqZyUT7C
 66g16i/l9x+qbX1Ys6m6Q73JcJTEPnEAaBZikKTEohI/9lbPK33S3HKlgPznUnyYOdJB42PcXAO
 87WnvkpM40+p0eNnW43F4gc
X-Received: by 2002:a17:90a:dfd0:b0:38e:659b:f366 with SMTP id
 98e67ed59e1d1-3966ce1df3fmr18948253a91.0.1787764204456; 
 Wed, 26 Aug 2026 10:10:04 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645d989cesm8866449a91.16.2026.08.26.10.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:10:03 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: daeho43@gmail.com
Date: Thu, 27 Aug 2026 01:09:54 +0800
Message-ID: <20260826170954.3878638-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_xpF2fBnJwXPATANo5bK0UWUEx2uNKpy2RCfZRzhOphoA@mail.gmail.com>
References: <CACOAw_xpF2fBnJwXPATANo5bK0UWUEx2uNKpy2RCfZRzhOphoA@mail.gmail.com>
MIME-Version: 1.0
X-Headers-End: 1wzH8c-0002YT-6s
Subject: Re: [f2fs-dev] [PATCH 0/2] f2fs: fix device alias state across
 remount
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
Cc: daehojeong@google.com, qwjhust@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Daeho,

The f2fs-tools companion patch was sent separately. It populates
dev_alias_ino[] when mkfs assigns the alias inodes, before calculating
the superblock checksum, so a filesystem created with the updated tools
has the mapping on its first mount.

Current mkfs.f2fs accepts an arbitrary slash-free alias_filename.
Enforcing basename equality will prevent new custom aliases, but it does
not handle existing filesystems: after release and remount, reserve
cannot identify a custom-named alias, and has_alias is not restored for
pinned allocation.

The added superblock commit is needed only when the mapping is first
recorded, and the release ioctl already ends with a synchronous
checkpoint.

Should existing filesystems created with custom alias filenames remain
supported? If so, a tools-only restriction does not seem sufficient.

Thanks,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
