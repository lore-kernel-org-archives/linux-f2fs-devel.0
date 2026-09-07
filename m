Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B133C79F9E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6HFT50fmCytCN9vLxoPa24mDLPyzb+GDaUI5OBMwAx4=; b=fv6ghRi0p3a3DYQCXJluUP90zV
	pJtqUMdK9cGTj3UTnKBSmIJfioaKC8Dy2EGKOlmOm+QvUCFQegTwd20tlJAzbhpfluVsmWezr5UPS
	wMuOeBpDBkEd8jxfNzpQJJd9XcgND/AVGUZ27wIpWkT75w+veq772u/sVDg5KZoO26SU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3SvW-0005jR-Qv;
	Mon, 07 Sep 2026 06:33:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1x3SvV-0005jL-Tl
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 06:33:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BmYQPN10Q5Qej5Y2o5u95UhxGgPeZTLRfAYiB3F9Bdg=; b=SSiCOhL6wNQh/T7KeEOmefPodc
 z5red3gY3oino16v7TNW6QdcJRSMRJ9zybFSAqH2WpiqzJmILe04d7VWYHJNe4LKbhSMfyPJQ2HE0
 bKtSWqhPQ9PErw0NvVqVfTakAgNvMaeyINFe4mGcMyUxq4BaznhA02yAAJNHF/8Ovh+I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BmYQPN10Q5Qej5Y2o5u95UhxGgPeZTLRfAYiB3F9Bdg=; b=KuUPscJHDv7+Dsn6vRqvdO1I4u
 8wiqX9T0nYB7ZdY6Y3qEYeSGOv4/TQ3iujdMJVhq0aTYCWw1bQN+zrVY7sT+M6VvhQifWyoe261xn
 k0P4C7paTNJ1/Bl07XcsW/L14HeDtr+SSn3Eu8/kJuSQe4LruDxsS2AETKooMfZilq7c=;
Received: from mail-pj2-f6.google.com ([74.125.227.134])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3SvT-0006EM-1I for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 06:33:55 +0000
Received: by mail-pj2-f6.google.com with SMTP id
 98e67ed59e1d1-3964e7720afso1992315a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 06 Sep 2026 23:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788762829; x=1789367629; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BmYQPN10Q5Qej5Y2o5u95UhxGgPeZTLRfAYiB3F9Bdg=;
 b=ImzC2GmTeJ5RmZwHXQXG+HqEjjMLeo/VjH52VD0cYWE4aK2kWbVzHWKkFQGMKCk/BK
 aHuJvqUEDD0dd7ZI5CCsz+QCjaDnbn4npeehc2PxZ//FoVxRly6l+oMKSVzdLxi2bA+c
 NZMobccraf1Tr920OJgWQ7yl+PDwrSjJIggub7uQx5QaIhnje0T4nwbMgPRQ5TxTZjqZ
 1YkCNRQBBIDv6aMTX3JJ+nbl7V3I7jmcbeLTIJvbUO7f9Y8vGS4iQYyWh28qDkFeAf4F
 x/y5JlbgSjqMcXCnS+0CWZDm5jGgoa9hK1IwSdsCScIFWBCTJRjutVF7vGFMa5l+zdxk
 K6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788762829; x=1789367629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BmYQPN10Q5Qej5Y2o5u95UhxGgPeZTLRfAYiB3F9Bdg=;
 b=GuburOkn0geLFqr6kzd9RsOKFhgbL/Xg31NSovmjXj1Tnd0KupZ+M6o0EPJSlMPxVf
 exa+A6e5wrFtRfvv1dvfDxzPK5y5zEAs7a7l4uwoEYDGKpGJ+jd3w2UJsGhFIDfh6PBg
 a4ncuyp9sxOUYK8Rz1vAeuwd1Z7ytjYrbn9N25szhy30BmSDBY0jrFemdRDUDs+Qt8yL
 5ePh/HL6KTVxw/jMLqlGsjM1WKZM/OfIs7RpL7h0p+NMYMsS+vhd97dkuLK18LgcYIxO
 cID5KcaXZ6o6lk7wO5qE+4IsAOz0aM0xui+PKNIJg86U5ZxccQ7RHFDX8p6ww8RpciZR
 Yx4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxR7sbMlf6uPX75iiMSD50TWccLOFmVGsJ/G2AV6a9HLXwg7CnpCVkKi0VJOf+CImOUY/pnLMfoqvGWsJmonUHE@lists.sourceforge.net
X-Gm-Message-State: AFuF++kF5fq6w+F3j5sB56Hyru9CRTpDE4CiiGTIhZcc/cXTtmuBOw8G
 +tbLWC8EGiPVYLPqO2J4bklNPmeMU5nSqUgiAS4iIzj1fTsfZRfKg4wW
X-Gm-Gg: AYBFou0fKNqZDb/k3KbYuulCfpYgZOFyVEbrLKy7lxdDtYr9lctsQgnFbwyqe7BTFTK
 /gbWH2VPcNjxYDt/BjRXZiYSINqXT0jVCN6nNwrsm368F06z9GjQ1lUQgXnDxXjLfipkLsom1lA
 XbmwkRz8zaAanxkSONk4aJPzZUuTdEieAY++Qalr1+B3k3/aBbLyFYPNQVn96ixVjY0Vcqh+vRr
 cLCUwB4KYlxTOwXvdGyl8bgFz8eqPYmy3qLqyUaBS2qsfN8hMsf0S8Te/PmBBSUlZ4WU55BYfia
 4ebM7cWP0KIlohOyc92Tm+lXj7eL2IYGEnU4B3oR82IrhvS1BZkxr1sfEz1h7yd5PFI+M1hhlQt
 EiHHq8YlZyDh7Teh5mMvEO/BmFzXRhNPJaJiEYT3jEDInH+yDgJJ5V2N9F1t7WeoVAWiH2z5WGn
 sq/Z3r6yrDmsNKqyeFZaHeFx3JWwBAzvgw/j2NDPIi9rNDJt/Fl1buJ7J9yd247gSxNHMjjnu31
 TsnmqRbQrLlRxhHnWe4Y6gkaDg=
X-Received: by 2002:a17:90b:544b:b0:398:c8ef:3644 with SMTP id
 98e67ed59e1d1-39b26203e7amr30545447a91.15.1788762829170; 
 Sun, 06 Sep 2026 23:33:49 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08d0d845sm25400204a91.17.2026.09.06.23.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:33:48 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: Daeho Jeong <daeho43@gmail.com>
Date: Mon,  7 Sep 2026 14:33:41 +0800
Message-ID: <20260907063342.2300274-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_ybFr8thjmy3ayzB0u+1f5vSFnR8km67J4bkOE7czSyYw@mail.gmail.com>
References: <CACOAw_ybFr8thjmy3ayzB0u+1f5vSFnR8km67J4bkOE7czSyYw@mail.gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x3SvT-0006EM-1I
Subject: Re: [f2fs-dev] [PATCH 13/14] f2fs: allow large folio support to
 writeable files
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

On Fri, 28 Aug 2026 10:44:46 -0700, Daeho Jeong wrote:
> In F2FS, newly created files almost always start with inline_data
> (`FI_INLINE_DATA`).
> Because f2fs_has_inline_data() is true during f2fs_new_inode() / f2fs_iget(),
> mapping_set_large_folios is skipped.
> When the file later expands and is converted to regular blocks in
> f2fs_convert_inline_inode(),
> `f2fs_mapping_set_large_folio()` is NEVER called.
> As a result, almost NO newly created file will ever use Large Folios
> during its lifetime.
> Fix: Call `f2fs_mapping_set_large_folio(inode)` inside
> `f2fs_convert_inline_inode()` once
> inline data is converted. Also consider using the standard
> `mapping_set_large_folios(mapping)`
> helper instead of `mapping_set_folio_min_order(mapping, 0)`.

I'm concerned that calling mapping_set_large_folios() here would
violate the specification for enabling large folios on a file, because
we would be enabling large folios on an active inode. Please take a
look at the comment of mapping_set_large_folios() in
include/linux/pagemap.h.

Thanks,
Nanzhe


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
