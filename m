Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79239C982FA
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W5DyeMPdgGhgZKderA5ED2N2ddhbpZHTf972FNpITRg=; b=UwDtzG+fjTA7DjNiUs6HScz6xY
	qiRcP3Qu1NIlVcjIq2GqD0pFWYRCWgq/5AR5d+oPoHs+clW0t8cLQUAIVTwCjupvEq+VTlazS0GZ9
	DiB0eFeRNtVjlBfA4sdcnqhLptFhr3srfT8KNCLoCcVk1PHgtpxNK8cdZ6ZpXek4X7eA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9HKD-0006qN-78;
	Wed, 23 Sep 2026 07:23:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x9HJi-0006pp-N0
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 07:22:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P98aXVbnTVCIn2RLl8j/V+gbDx0DMTPfumfUioCK0H4=; b=h/bp6ErABuD0dfqaj3wdl81d6+
 IB5PEbQc6ge+M8I/+zC6N6OpD5U7qAepPv+SrBmZYlNF/NBSEJfIv6DCa8hzY6gpAn5VzumCoWtj2
 fPkEVdzHaATVWmyOEUpm4ddnRd31/6LYcdPRb1lLDN4+iKY4Cix1F2GmtsatxAqJsvng=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=P98aXVbnTVCIn2RLl8j/V+gbDx0DMTPfumfUioCK0H4=; b=cdaNkM0KkPI4t/KDb2mSfGRAYb
 9BrrierPFfeCnUiSbHHgc4DL4CaOc3444D/UijFc0dc3XyMDETkHm1y2edm8jtbGXveLHIjhzp8eM
 AVlOAqfcwmmeVDN8bCibzbt0Qvln8lMS83fbIdpHKDdDXn7f8XQkHNLWDn9dW/OnrsSU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x9HJi-0006BH-Vn for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 07:22:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 559F4600AA;
 Wed, 23 Sep 2026 07:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B121F000FF;
 Wed, 23 Sep 2026 07:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790148173;
 bh=P98aXVbnTVCIn2RLl8j/V+gbDx0DMTPfumfUioCK0H4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=jPn7D38zZATIIjH4keWV7URVeLakgdYo79VDeRv7ysp+33dKlrXd+G4O0JmKD1YGo
 o37sZ4iQRGowecUIXgnxxTVa4BMc3OF6o2jpul1w17SKa8uxu7WklftTB4HSt3b133
 WEgvke3wUmJf6qbZ57ZiRrNm/pBpgPbWZocuzSzYx5EzNGfYGSVrlvMHOGg4Td/7og
 djx2+yTOVU+5zsMxBsMv5dr+SwfJPqhiCIP/SS0MZdGBz9WRDJFHm7hZvB7Y8aqEIt
 DKpdHYB3wrsk/0/aAtMd7clJKKe3Xo2YbdRZui9QKJjM7q3JxnS1jLCvDsTujSvMlK
 vhmJWX3eIdShQ==
Message-ID: <5f954f1e-c4b8-4565-a2f2-04d4067293d2@kernel.org>
Date: Wed, 23 Sep 2026 15:22:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
References: <51c3f1f9-7e91-4f9a-9f22-d1ba8df357c6@kernel.org>
 <20260923032131.2227703-1-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260923032131.2227703-1-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x9HJi-0006BH-Vn
Subject: Re: [f2fs-dev] [PATCH v2 04/14] f2fs: support atomic file large
 folios buffered write
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Nanzhe Zhao <nzzhao@126.com>,
 Juan Yescas <jyescas@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-f2fs-devel@lists.sourceforge.net, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/23/26 11:21, Nanzhe Zhao wrote:
> I think I can extract the duplicate logic in a helper and the full change
> may be like this?
Alright, is there a way to relocate below code block before f2fs_balance_fs()?

	if (folio_test_large(folio)) {
		if (f2fs_is_atomic_file(inode))
			err = prepare_large_folio_atomic_write_begin(inode,
					mapping, folio, pos, len);
		else
			err = prepare_large_folio_write_begin(inode,
					folio, pos, len);
		if (!err)
			return 0;
		if (err == -EAGAIN) {
			f2fs_folio_put(folio, true);
			goto repeat;
		}
		goto put_folio;
	}

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
