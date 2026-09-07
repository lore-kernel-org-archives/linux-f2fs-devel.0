Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0397FC79F9E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 03:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NX0u3eEVln2hFuSaQhE6YwFrsESV4v6sp9i8ED8ndck=; b=T60fzBWbjdR7vSwD8nHU7th0OT
	iK5Ue/iGyOCE2TBSr0CxaRLczxtf2dw5mFSPlKuwRQzlAyx9CW3krYNekbmzrLUpNqx7P65U6H9+p
	m22bS9PVYindeAznZBdmSaqHophNWd7aWh5T0CR17VupAc9guxF2du9Bff6czTurjruw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3QUo-0001NV-8e;
	Mon, 07 Sep 2026 03:58:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1x3QUa-0001N8-LX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 03:58:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hdsl9+aa24pT+K8TnYj8ZVm9GMkxSGzxJ21FCr9owyQ=; b=ZOYSIHIzWG2DRAb5HiN185ZpkE
 HngGX+oUWr93Vzms3TfxiXZq5/dBgzoMui/znzrjj/mNcRSCzzYsx/ow4F+dT6L2Ze9/PSuAefpxM
 aWMPdgQfdEEkmW5KVex5uBvA+LmdECqxgYMWqU8k7Al73NwLbzHBlhTEjwPHaiFgaQ9U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hdsl9+aa24pT+K8TnYj8ZVm9GMkxSGzxJ21FCr9owyQ=; b=NRkQUqlrr/+P35KOzUvbDeqK8z
 AOmp6iDUrplIiz5F0/yHCtF063X9b3jqlDhek8gmTMyGW6mIQVcQLjFVwI5a7id7ra/6P+n9M8y+g
 41KR1gUj05qGXpzKdrQ9+K34y3PHf/yiGL+cC/Gd5yDTg5q5Tzm39GJiLobbvBGxyMNI=;
Received: from mail-pj2-f8.google.com ([74.125.227.136])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3QUZ-0002uD-B7 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 03:58:00 +0000
Received: by mail-pj2-f8.google.com with SMTP id
 d9443c01a7336-2d8fcda61c8so11430475ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 06 Sep 2026 20:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788753474; x=1789358274; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hdsl9+aa24pT+K8TnYj8ZVm9GMkxSGzxJ21FCr9owyQ=;
 b=gnvjTbkEvjvm7C+yq3ORq9KO//qEkGbkd5BB5yGnndUvAxrXqPxa1boVnMYFH38iQ7
 OavbenRlnVxKqMsBBQ5Enb2xSgHSX77ZJ9QOKB66UZLVSyXWUEiOCta2KyL2c7IiZbet
 t+Nw9arduI89OwMIu7eJuAbGRpGh4RwrnjlMT3ZTkYsbcTBV+bi6VY00o2CpfgNWs+Of
 CJGf5kUGmC9hpmtECpl2XyBmI/x3Va7+5TM0B/dJ0uLzbv62hKJ+oWOY5AmK3IjwVlhn
 hEzqx6AVDii4U7cFzjO1dyyPnmsLsYow4jQftG93JOFcuzzqsp3NQIwf94m9fdujOlFA
 7PHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788753474; x=1789358274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hdsl9+aa24pT+K8TnYj8ZVm9GMkxSGzxJ21FCr9owyQ=;
 b=ZS7cFdQXt6Ak1m21A1293J6pVmbpcFvdLh5HOzPm/8mz4u8BQtV0hQA6+Gek3j4ui3
 Puf91QsoaxZmAQg8I5W5M63xh/mPKU878N8wXJSiPRhZdKNSbvN/11yCXQPoYwTaMjx5
 b1fQmc4MMYJmXe1UJzmt52ISXiT7gnSdL3PxpjmO+0sgVjIYVrhpWOEqHSkcRITUrFxi
 Oi6qfbEdc1vHVZC80szRJ3h6Sk0qrsnRIaMLp5RJ0yPuz40SmrloC2B72Ge6Io5JIBw8
 PR7ZVxAGqD1/wkpsDqtLFpOu+p3/wMmfHE4eZKRtHWYT/iZ3L5jWMJk1lj6yRxYiiR+f
 xQ/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBydxMczCPoRO051Ejaj8CwRLso62sRr6IMYsKkTkSLBU/tT/K5/w/CMW67LNy9MQ5YhceiOCpv22xzyPXWgWgyj@lists.sourceforge.net
X-Gm-Message-State: AFuF++mwFCOVUy6ADtkTtcE4z5ZG8XVB55SWai7IxNwTbG+ubf47LV01
 60AKRL3wgqgtiGWC5nH2F4obNWZ+3iPdxRr42e5pXFPIV3FLNIPO3zZB
X-Gm-Gg: AYBFou2rG5UsNUVAuATCpWSTgN87Qr1gfwvgOFTeeXhhKo3wPowrb38s0JtK88Asll4
 zwJkIhewcSIa/y3RL/djAzfp7YEKRUu8i6vitQ+EeWPru63+GwT0d/IE0nQgPWGPT9n9FUYVnwt
 Ap5x73bkL9xOyNGLKK7BXKPITwxlYsS+cfpISVvav3arTzEToUS8BtgEg56znLDjllgqqchLli2
 Np3be8lBSBufC/JNDZXXkBh1WTyF2S1bDDg0g7EE3rVvbdN9f+PTKozM4UnhVAFbiRsL2gLYfxW
 liN6ODjL04ozU99ciKTa5KujgJ6RGOWYB0l3hdVpWPNMc/7AQo7WOuLkqIa5vb2wym4Q3e7ivje
 ob0nGSph+LQgpdV5REBo9UvE7f8V+6ipaKGA3sumMHtJBtnBCRjNN1mMsmomjRTVwB484ziQS7F
 tuJi8SYYvvQuktPmmqSoAo0kZndkOv0lVmb2pqJ7BHQsVH6BgqbygA8/rqgc3UHTZ7uCh9cZUJR
 /3QLOmn2BSusUJZj0lXPYaekQ==
X-Received: by 2002:a17:903:2290:b0:2db:63cb:1b17 with SMTP id
 d9443c01a7336-2db63cb1b8dmr9031135ad.18.1788753473487; 
 Sun, 06 Sep 2026 20:57:53 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1497d4dbsm37186365ad.33.2026.09.06.20.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 20:57:53 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: Daeho Jeong <daeho43@gmail.com>
Date: Mon,  7 Sep 2026 11:57:45 +0800
Message-ID: <20260907035746.2189242-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_yX2vdMhZEUyYH6TaS1wHNp3axu-bjuZY+3XsnfM4oGzQ@mail.gmail.com>
References: <CACOAw_yX2vdMhZEUyYH6TaS1wHNp3axu-bjuZY+3XsnfM4oGzQ@mail.gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x3QUZ-0002uD-B7
Subject: Re: [f2fs-dev] [PATCH 05/14] f2fs: support large folio writeback
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, 3 Sep 2026 21:04:36 -0700, Daeho Jeong wrote:
> In __has_merged_page(), target->mapping is directly dereferenced. For tail
> pages, target->mapping contains compound_head metadata rather than a valid
> address_space pointer, leading to a kernel crash when accessing
> target->mapping->host.

Thanks for the review.

I've been testing on 6.18-based (Android) and 7.2-rc5 trees, and in
both of them bio_for_each_folio_all() goes through bio_first_folio(),
which resolves the head folio from the bvec directly:

    fi->folio = page_folio(bvec->bv_page);

So the folio yielded to __has_merged_page() should always be the head
folio there.

Are you testing on a 6.12-based Android kernel? In 6.12,
__has_merged_page() still iterated with bio_for_each_segment_all() and
took bvec->bv_page directly as target, so a tail page would make
target->mapping point at the compound_head metadata and crash on
target->mapping->host.

If so, would it be possible to retest on a 6.18 Android kernel, where
the iterator normalizes to the head folio?

Thanks,
Nanzhe


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
