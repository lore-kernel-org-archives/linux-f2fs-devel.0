Return-Path: <SRS0=+qdT=II=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53145C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 10 Mar 2021 01:31:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB17650F2;
	Wed, 10 Mar 2021 01:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB17650F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lJnh6-000224-2I; Wed, 10 Mar 2021 01:31:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1lJnh4-00021w-3R
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Mar 2021 01:31:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/jieg46/qBsTWIzvz7rFEZ9226hArHhJ5L40Zh+3NNo=; b=K/jZc9AFDTWj8DUWvwBXzFcnkV
 enA/0oJtMTWaSNjxsVZFwLA5py18y/mtcvHui35oLJGzHbA2DZsYMxo56pib5B7JJEOMfiW9dHjVD
 ac2F0dBAjyP3yjqbvrvMCRpZCuMuJ1/AOp0bP3l8vzXdeCWiM86bJ/juBvHAfBi1r/Ms=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/jieg46/qBsTWIzvz7rFEZ9226hArHhJ5L40Zh+3NNo=; b=AK52JZJbn4eOBjhq7PevHs8ANd
 mtu36qsuXKvbGRgH+XrBwzy4esWZJ+Jxy00X+lco6ygdblrTUU7rkEogxHMFDxRNcVJSoRRje06/Y
 9HbCANXOUdpv76pjsgIGy8syL64xygNWYBmcMm6erumCeA7rFVB82mOUQU2GrQK/A8sY=;
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lJngv-006Q1r-6q
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Mar 2021 01:31:22 +0000
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DwDyR1PCfzkWSn;
 Wed, 10 Mar 2021 09:29:35 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 10 Mar
 2021 09:31:01 +0800
To: Daeho Jeong <daeho43@gmail.com>
References: <20210305022402.2721974-1-daeho43@gmail.com>
 <2f2abc41-24d5-6795-44fe-b770ed8514df@huawei.com>
 <CACOAw_woQGgTy_hTfdcFufA7VG3cBVSN9vSD5bubvTeo+3wxsg@mail.gmail.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <203c1945-9d48-098e-fa8f-1c86b1086ae3@huawei.com>
Date: Wed, 10 Mar 2021 09:31:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACOAw_woQGgTy_hTfdcFufA7VG3cBVSN9vSD5bubvTeo+3wxsg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
X-Headers-End: 1lJngv-006Q1r-6q
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add sysfs nodes to get accumulated
 compression info
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyMS8zLzkgMjE6MDAsIERhZWhvIEplb25nIHdyb3RlOgo+IDIwMjHrhYQgM+yblCA57J28
ICjtmZQpIOyYpO2bhCA2OjIyLCBDaGFvIFl1IDx5dWNoYW8wQGh1YXdlaS5jb20+64uY7J20IOye
keyEsToKPj4KPj4gT24gMjAyMS8zLzUgMTA6MjQsIERhZWhvIEplb25nIHdyb3RlOgo+Pj4gRnJv
bTogRGFlaG8gSmVvbmcgPGRhZWhvamVvbmdAZ29vZ2xlLmNvbT4KPj4+Cj4+PiBBZGRlZCBhY2Nf
Y29tcHJfaW5vZGVzIHRvIHNob3cgYWNjdW11bGF0ZWQgY29tcHJlc3NlZCBpbm9kZSBjb3VudCBh
bmQKPj4+IGFjY19jb21wcl9ibG9ja3MgdG8gc2hvdyBhY2N1bXVsYXRlZCBzZWN1cmVkIGJsb2Nr
IGNvdW50IHdpdGgKPj4KPj4gSSBub3RpY2VkIHRoYXQgdGhlc2Ugc3RhdCBudW1iZXJzIGFyZSBy
ZWNvcmRlZCBpbiBleHRyYSByZXNlcnZlZCBhcmVhIGluCj4+IGhvdCBub2RlIGN1cnNlZyBqb3Vy
bmFsLCB0aGUgam91cm5hbCB3aWxsIGJlIHBlcnNpc3RlZCBvbmx5IGZvciB1bW91bnQKPj4gb3Ig
ZmFzdGJvb3QgY2hlY2twb2ludCwgc28gdGhlIG51bWJlcnMgYXJlIG5vdCBzbyBhY2N1cmF0ZS4u
LiBkb2VzIHRoaXMKPj4gc2F0aXNmeSB5b3VyIHJlcXVpcmVtZW50Pwo+Pgo+IAo+IFllcywgd2Ug
YXJlIHNhdGlzZmllZCB3aXRoIGp1c3QgZ2V0dGluZyByb3VnaCBudW1iZXIgb2YgdGhlbS4gQnV0
LCBpdAoKQWxyaWdodCwKCj4gd291bGQgYmUgYmV0dGVyIGlmIHlvdSBzdWdnZXN0IG1vcmUgYWNj
dXJhdGUgd2F5LiA6KQoKSSB0aGluayB0aGlzIGlzIHRoZSBjaGVhcGVzdCB3YXkgdG8gc3RvcmUg
cm91Z2ggbnVtYmVyLCBvdGhlcndpc2UgaXQgbmVlZHMgdG8gY2hhbmdlCmYyZnNfY2hlY2twb2lu
dCBzdHJ1Y3R1cmUgbGF5b3V0IG9yIGFkZCBhIG5ldyBpbm5lciBpbm9kZSB0byBwZXJzaXN0IHRo
ZXNlIHN0YXQKbnVtYmVycyBpZiB3ZSB3YW50IG1vcmUgYWNjdXJhdGUgb25lLgoKPiAKPj4+IGNv
bXByZXNzaW9uIGluIHN5c2ZzLiBUaGVzZSBjYW4gYmUgcmUtaW5pdGlhbGl6ZWQgdG8gIjAiIGJ5
IHdyaXRpbmcgIjAiCj4+PiB2YWx1ZSBpbiBvbmUgb2YgYm90aC4KPj4KPj4gV2h5IGRvIHdlIGFs
bG93IHJlc2V0IHRoZSBzdGF0IG51bWJlcnM/Cj4+Cj4gCj4gQWN0dWFsbHksIEkgd2FudCB0byBo
YXZlIGEgd2F5IHRvIGNsZWFyIGFueSBzdGFsZSBudW1iZXIgb2YgdGhlbSwgYnV0Cj4gSSBhZ3Jl
ZSB3ZSBkb24ndCBuZWVkIHRoaXMuCj4gCj4+IFdoeSBub3QgY292ZXJpbmcgYWxsIGNvZGUgd2l0
aCBtYWNybyBDT05GSUdfRjJGU19GU19DT01QUkVTU0lPTiwgc2luY2UgdGhlc2UKPj4gbnVtYmVy
cyBhcmUgb25seSBiZSB1cGRhdGVkIHdoZW4gd2UgZW5hYmxlIGNvbXByZXNzaW9uLgo+Pgo+IAo+
IEkgd2FudGVkIHRvIGtlZXAgdGhlIGluZm8gZXZlbiBpbiB0aGUga2VybmVsIHdpdGggZG9lc24n
dCBzdXBwb3J0Cj4gcGVyLWZpbGUgY29tcHJlc3Npb24gaWYgdGhvc2UgaGFkIGJlZW4gd3JpdHRl
biBvbmNlLiBXaGF0IGRvIHlvdQo+IHRoaW5rPwoKU3VyZSwgaWYgc28gaXQncyBmaW5lIHRvIG1l
LiA6KQoKVGhhbmtzLAoKPiAKPj4gVGhhbmtzLAo+IC4KPiAKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlz
dApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNv
dXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
