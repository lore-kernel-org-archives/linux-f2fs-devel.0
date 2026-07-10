Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C24EC44501
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2026 01:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DETmMnPJFuNL9iA66eA+zP7d2CQzBg/y5624LhQ9egU=; b=K/R33TUuTd8bdhN9VOVjIjsEwG
	S9JSm7nSBlc4w4fgeaONKmTSQYvkLq+o9i3/l7tNIG7E5dAKmO2uexb7JQNRWpP4mvqkyzk6XPRF5
	qBpOp15buny0iAP2tK+c6I3SApBa04JeWUQA9I9DFuDCk9/VeL2hdIlcLVKVo2l4IL3M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1whzr0-0001gq-Pi;
	Fri, 10 Jul 2026 01:16:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1whzqd-0001fH-J0
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 01:16:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JKv40+Rzw+MoVgpFHomEnuLuSrw5OPIiQZ1nay2qfrI=; b=ErIFGVYNvN47MLx85YlJ6u1MsL
 8lfR2JAx1ZpuAWMQkzmSBlNRg3zM10SqVIU8+wTmTQzlLkFV6iP/dqAKn/rwHVMlF5kTz12oWUWOA
 9CKOx58YE0qh3LTQ2/sxygZ28K6y6h81LzIRzTAx88RCw2m4dPtsOKjSdAEaPbEDA+P0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JKv40+Rzw+MoVgpFHomEnuLuSrw5OPIiQZ1nay2qfrI=; b=O92Lh9E53U3s+FR0xj4Muhbt+J
 reK9a/xibG19QYMKWJ8tGcRzXICwZzshSMx1i+HhLwi7yPb7GjhqwH18gLUG6pe/CV3FJL/eKTtov
 EmaNJp/aiNGO3aAp6kuEStT8MMrA6xB3yqtZIczf/J6YSHc7JZpU8zRSYEBrOdAXxWtE=;
Received: from m16.mail.126.com ([220.197.31.6])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1whzqc-0004w0-DI for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 01:16:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=JK
 v40+Rzw+MoVgpFHomEnuLuSrw5OPIiQZ1nay2qfrI=; b=crtjClSM7mkpJ8BrJV
 0a2qd77WzCoTglY7tsfuJkCUAeeO+qQx175rjSQaioi0OvDZ21CoDFXGASV7Fy+r
 GYiB4MRZorq841kztjvnYkOrV37OGXj9y172md8i0gMUwuk8Lzl8okXiK1CCoQcI
 dc5v4lM3CrCag7iPzcJk86Iy8=
Received: from YLLaptop.. (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wD3p+G2R1Bq0M_wDA--.7522S3; 
 Fri, 10 Jul 2026 09:15:37 +0800 (CST)
To: Chao Yu <chao@kernel.org>
Date: Fri, 10 Jul 2026 09:15:33 +0800
Message-Id: <20260710011534.2307696-2-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a9b257fd-68ce-45a6-b4df-be5faf583e2d@kernel.org>
References: <a9b257fd-68ce-45a6-b4df-be5faf583e2d@kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3p+G2R1Bq0M_wDA--.7522S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw4xKryrXFWrurW3JrWUurg_yoW5Wryxpr
 Z5GF1vyr4fGFy5W3WUJr1Svry7Ar9xXF4DZay3Cw4fJ3W2qw1ruFn7J34j9F4fJry8ZFn3
 tay5CFn3WF4YyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNiSLUUUUU=
X-Originating-IP: [39.144.78.103]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsBmufmpQR7nqmgAA3N
X-Headers-End: 1whzqc-0004w0-DI
Subject: Re: [f2fs-dev] [RFC PATCH v2 01/10] f2fs: extend folio state for
 large folio write path
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 Bo Zhang <zhangbo56@xiaomi.com>, Kalesh Singh <kaleshsingh@google.com>,
 Ryan Roberts <Ryan.Roberts@arm.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> Seems there are redundant codes below, let's have a try to wrap them w/ a macro for cleanup?

Got it, thanks!
How about the following example implementation?

static inline unsigned long f2fs_folio_get_private_flags(const struct folio *folio)
{
	if (f2fs_folio_has_state(folio)) {
		struct f2fs_folio_state *ffs = folio->private;

		return ffs->private_flags;
	}

	return (unsigned long)folio->private;
}

static inline void f2fs_folio_set_private_flags(struct folio *folio,
						unsigned long flags)
{
	if (f2fs_folio_has_state(folio)) {
		struct f2fs_folio_state *ffs = folio->private;

		ffs->private_flags |= flags;
		return;
	}

	if (!folio_test_private(folio))
		folio_attach_private(folio, (void *)flags);
	else
		folio->private = (void *)((unsigned long)folio->private | flags);
}

static inline void f2fs_folio_clear_private_flags(struct folio *folio,
						 unsigned long flags)
{
	unsigned long private;

	if (f2fs_folio_has_state(folio)) {
		struct f2fs_folio_state *ffs = folio->private;

		ffs->private_flags &= ~flags;
		return;
	}

	private = (unsigned long)folio->private;
	private &= ~flags;
	if (private == BIT(PAGE_PRIVATE_NOT_POINTER))
		folio_detach_private(folio);
	else
		folio->private = (void *)private;
}

#define PAGE_PRIVATE_GET_FUNC(name, flagname) \
static inline bool folio_test_f2fs_##name(const struct folio *folio)\
{\
	unsigned long priv = f2fs_folio_get_private_flags(folio);\
	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |\
			     (1UL << PAGE_PRIVATE_##flagname);\
	return (priv & v) == v;\
}\
static inline bool page_private_##name(struct page *page)\
{\
	return PagePrivate(page) &&\
		test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) &&\
		test_bit(PAGE_PRIVATE_##flagname, &page_private(page));\
}

#define PAGE_PRIVATE_SET_FUNC(name, flagname) \
static inline void folio_set_f2fs_##name(struct folio *folio)\
{\
	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |\
			     (1UL << PAGE_PRIVATE_##flagname);\
	f2fs_folio_set_private_flags(folio, v);\
}\
static inline void set_page_private_##name(struct page *page)\
{\
	if (!PagePrivate(page))\
		attach_page_private(page, (void *)0);\
	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page));\
	set_bit(PAGE_PRIVATE_##flagname, &page_private(page));\
}

#define PAGE_PRIVATE_CLEAR_FUNC(name, flagname) \
static inline void folio_clear_f2fs_##name(struct folio *folio)\
{\
	f2fs_folio_clear_private_flags(folio,\
			1UL << PAGE_PRIVATE_##flagname);\
}\
static inline void clear_page_private_##name(struct page *page)\
{\
	clear_bit(PAGE_PRIVATE_##flagname, &page_private(page));\
	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER))\
		detach_page_private(page);\
}



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
