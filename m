Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCE6C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KamgOu087a6saqfDLw7DOy2YxeaxC+uk1iHK6GtO/j4=; b=k8tmB7hEnWqLUvtduwaupkld0W
	fjKcxR8XzoyHMQNgJf8gm+5HJZRNJf3b+b8PZM9qVLX4+OK227aCgOD7o4lBMBEjgkXPts/2hrfOk
	ssViktVFH8aFuz4dbQmBDJNArhqXDxN/vVudZFWoRpPXujDDveaupbbI+jkRnACsUZrI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wi5vR-0008Td-F0;
	Fri, 10 Jul 2026 07:45:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wi5vP-0008TV-3m
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 07:45:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lAtidVHt3txYd7QiAwxP1Zg6VS9bpT5GNQz5miA0BfM=; b=Eadsxba3ZqzyDBGqkMGzqoZawi
 g2s0hDLOjam+zOOlPbm8mnVQSr62MMweCLs8hrlSa71zw1bMg0Ihd5GfexwU56zg1RSsUN3U49eUP
 OQG4l1eyZBuJOhXu8j/H2aHEj53QN/YtLwQZW03ueL16WqFwx4N1Hkrve1Lkhvp3mOM0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lAtidVHt3txYd7QiAwxP1Zg6VS9bpT5GNQz5miA0BfM=; b=Ti/n6a93VPSfLLXODvcbnckQnA
 vLPDIQQvrYOXaS9jEOsLaH2g8AJfQlyxis5G8Lfadpinq0ByUTaNg+63SoI5wwlGLuo1Em6jkRo18
 I/WaH3YhKLJ3F2+OnwaIwWWH3kI3Hzl7v0YhZvt8OCwGCmQWgpzILXXPFd4lJm2GZw00=;
Received: from m16.mail.126.com ([220.197.31.7])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wi5vO-0008Oi-Hj for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 07:45:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lA
 tidVHt3txYd7QiAwxP1Zg6VS9bpT5GNQz5miA0BfM=; b=nnn1ZKmxiMi0s1QW0z
 w4QGoZEndFEoOIgRIsFU7GAUEpKQX/Oksg74atfYdBQLzHcM7eZUwmOdFme0vEZC
 vdSXrIrscqR2pXAZUNnNl0+B6/p31e7lbI0ZWF1tzSMHKBSQTiAaMZwEHrzAnFu3
 zLsxjJz8hHgQOutDTVGwP7lBs=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PikvCgD3f4_3olBq0cHyCg--.58119S2;
 Fri, 10 Jul 2026 15:44:56 +0800 (CST)
To: Chao Yu <chao@kernel.org>
Date: Fri, 10 Jul 2026 15:44:55 +0800
Message-ID: <20260710074455.704198-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f1ad5d3d-f4c5-498f-8378-a5efff74a458@kernel.org>
References: <64ce7a28-992d-4d20-bbb1-b76943911ab4@kernel.org>
 <20260710011534.2307696-3-zhaonanzhe@xiaomi.com>
 <f1ad5d3d-f4c5-498f-8378-a5efff74a458@kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: PikvCgD3f4_3olBq0cHyCg--.58119S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr4fGF13uryfuw1fAw17GFg_yoWkXrc_uF
 nI9w1vya4xW395CFZ3Ga4rXrWFgFW8KryUC3y8Xay3K345tFZ5Zr4kWr98Jr1kXw1avr9x
 Gr1vvw40vF42gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUU73PUUUUU==
X-Originating-IP: [114.247.175.250]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBoxiVZWpQovhBYwAA3J
X-Headers-End: 1wi5vO-0008Oi-Hj
Subject: Re: [f2fs-dev] [RFC PATCH 3/9] f2fs: support regular file buffered
 writes on large folios
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
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-f2fs-devel@lists.sourceforge.net, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <Ryan.Roberts@arm.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Pengfei Li <lipengfei28@xiaomi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> > Both the error path and the normal path will eventually reach the out label path,
> > and out will call f2fs_put_dnode(&dn) if get_dn is true.
> > Or am I missing something?
>
> For above case: both head and tail has partial updated data, then we call
> f2fs_get_dnode_of_data() twice, but call f2fs_put_dnode() once?

I think f2fs_put_dnode() will be called twice in that case.

The out label is still inside the while loop body. For each block returned by
f2fs_find_next_need_read_block(), get_dn is reset to false first. If
f2fs_get_dnode_of_data() succeeds, get_dn is set to true, and the same
iteration will fall through/goto out and call f2fs_put_dnode(&dn).

So for head and tail, the flow should be:

head: get dnode -> read/zero -> out -> put dnode
tail: get dnode -> read/zero -> out -> put dnode

If head and tail are the same block, the first iteration marks it uptodate,
so the next f2fs_find_next_need_read_block() will not return it again.

Hmmm, if the current control flow is so easy to misread, would you like me
to change it a bit to make the per-iteration dnode lifetime more obvious?

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
