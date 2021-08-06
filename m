Return-Path: <SRS0=dspS=M5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52088C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Aug 2021 06:34:13 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3D2661164;
	Fri,  6 Aug 2021 06:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F3D2661164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mBtQl-0004Vh-53; Fri, 06 Aug 2021 06:34:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <hare@suse.de>) id 1mBtQj-0004Vb-Uy
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Aug 2021 06:34:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Zl842g0bWie6vqzv1++O8vKc9vEk5pvbJfOEXYua4rQ=; b=BV1FGO5619vWZG2n+NP8B1/7Ss
 OpkHn+q0RiWdTJ773KsC1Mp2vBH/nui+9avAJuF8rxW6uiKw+PJBuQCgfec6QL/wXkIwG9p2eEce7
 YikBbZbkGljRW/vAnNW//sXVkduVqoyIb6FcsbCi/CaZ6uPQGgqgk/Ajptt3pmQazuho=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Zl842g0bWie6vqzv1++O8vKc9vEk5pvbJfOEXYua4rQ=; b=DrMJd0IZexRjbCVUxfCQZv/Atg
 Z8Xui+oURpkM83TMhPqmP4W86XxpMYeJ8QSet3gUEAUUKrjpVSCtmF+JpDmWV3NuqXHhDYA3TzePC
 Q0VdnUEUGFeK+GLRsgEzFcf4XfQWFIvdRgFfCZF22kDYahjPnZD+34Z4nzNTtYzoNcKg=;
Received: from smtp-out2.suse.de ([195.135.220.29])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1mBtQc-0001kj-1t
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Aug 2021 06:34:05 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D1EB21FE9B;
 Fri,  6 Aug 2021 06:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628231631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zl842g0bWie6vqzv1++O8vKc9vEk5pvbJfOEXYua4rQ=;
 b=z47Oc/iONezDdNpSOLmR5ppTBkF49M/RJp84t/0LC0p858kh6+SrDPhrhJTICoRw9awRfz
 PFWNMEgB7PweXJ5izNQUaFzyu8VUcG9SuNQieJJ6SL8WLmNYViw8FoH3ySLIH/pXqlrZOR
 mmUHNJDkdE8FZked6YK/th66pqg6m4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628231631;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zl842g0bWie6vqzv1++O8vKc9vEk5pvbJfOEXYua4rQ=;
 b=Uh3Df/Ps6hlMO/dGmNVjG3InGRAZfhScidCoPj/Oo8hgOsy/gwNmD2wS09V3t11gLKHXVy
 h/RDWQHSqlECSlDA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 88DEF136D9;
 Fri,  6 Aug 2021 06:33:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id qwLpHs/XDGGmBQAAGKfGzw
 (envelope-from <hare@suse.de>); Fri, 06 Aug 2021 06:33:51 +0000
To: Damien Le Moal <damien.lemoal@wdc.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Paolo Valente <paolo.valente@linaro.org>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <yuchao0@huawei.com>
References: <20210806051140.301127-1-damien.lemoal@wdc.com>
 <20210806051140.301127-2-damien.lemoal@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <763e1397-f738-d812-52a2-759e1974ecd7@suse.de>
Date: Fri, 6 Aug 2021 08:33:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806051140.301127-2-damien.lemoal@wdc.com>
Content-Language: en-US
X-Headers-End: 1mBtQc-0001kj-1t
Subject: Re: [f2fs-dev] [PATCH v2 1/4] block: bfq: fix
 bfq_set_next_ioprio_data()
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gOC82LzIxIDc6MTEgQU0sIERhbWllbiBMZSBNb2FsIHdyb3RlOgo+IEZvciBhIHJlcXVlc3Qg
dGhhdCBoYXMgYSBwcmlvcml0eSBsZXZlbCBlcXVhbCB0byBvciBsYXJnZXIgdGhhbgo+IElPUFJJ
T19CRV9OUiwgYmZxX3NldF9uZXh0X2lvcHJpb19kYXRhKCkgcHJpbnRzIGEgY3JpdGljYWwgd2Fy
bmluZyBidXQKPiBkZWZhdWx0cyB0byBzZXR0aW5nIHRoZSByZXF1ZXN0IG5ld19pb3ByaW8gZmll
bGQgdG8gSU9QUklPX0JFX05SLiBUaGlzCj4gaXMgbm90IGNvbnNpc3RlbnQgd2l0aCB0aGUgd2Fy
bmluZyBhbmQgdGhlIGFsbG93ZWQgdmFsdWVzIGZvciBwcmlvcml0eQo+IGxldmVscy4gRml4IHRo
aXMgYnkgc2V0dGluZyB0aGUgcmVxdWVzdCBuZXdfaW9wcmlvIGZpZWxkIHRvCj4gSU9QUklPX0JF
X05SIC0gMSwgdGhlIGxvd2VzdCBwcmlvcml0eSBsZXZlbCBhbGxvd2VkLgo+IAo+IENjOiA8c3Rh
YmxlQHZnZXIua2VybmVsLm9yZz4KPiBGaXhlczogYWVlNjlkNzhkZWMwICgiYmxvY2ssIGJmcTog
aW50cm9kdWNlIHRoZSBCRlEtdjAgSS9PIHNjaGVkdWxlciBhcyBhbiBleHRyYSBzY2hlZHVsZXIi
KQo+IFNpZ25lZC1vZmYtYnk6IERhbWllbiBMZSBNb2FsIDxkYW1pZW4ubGVtb2FsQHdkYy5jb20+
Cj4gLS0tCj4gICBibG9jay9iZnEtaW9zY2hlZC5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gClJldmlld2VkLWJ5OiBIYW5uZXMgUmVp
bmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWlu
ZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRl
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0
d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAz
NjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZl
cgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9y
Z2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4
LWYyZnMtZGV2ZWwK
