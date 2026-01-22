Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2ADC44536
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jan 2026 02:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tlz7t7EFsCO1WK6M9N1K2sgDQH/PeedcS7MZR4l4Gi4=; b=BQpj1+e4WgijeNmimOwidYOmyi
	pmGjvDJiC8xC/PDjXJdJMEhQHPg+ODl0gBy2AhWVAUf5SJNaVIhmv0nRGKEIPJGzcwdMltEItQ2PC
	0JEJbpgzdnBxucnKMHw/I6a+pp639v6zw53wPfX6qCLlopcMAxQDl+fQQPVzCNltI1f4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vik1h-0002qY-A7;
	Thu, 22 Jan 2026 02:02:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1vik1f-0002qI-Gn
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jan 2026 02:02:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IRNTD8aA6LWMkBMmEmDIcJ/0jijgrN8LtcD50K0ogEA=; b=eSURBkbwQlb7YlaxWPpparesZD
 VdqoX19s20ejfsbH3fD8zozk6SeKElijArvGxVQj3QIYUxJcO5iVo+e8n8NC3DINlwOwulmDUzjgI
 +OuVQxMe7svOX+TXKO2fIins8X/YjIo5t2Zvc697zrdbk5ooD64e6WoOu+yJgA3IHkdI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IRNTD8aA6LWMkBMmEmDIcJ/0jijgrN8LtcD50K0ogEA=; b=FDCKed5cejS9oezDZjdvNEncfN
 K39bhyr1fKJ3bzDWWzmZ2nWq3NqRiCGiAP9vB/Zrm6rRBQ/hFK5HdOQw8xaFJdsst6c/EBkG7zrGA
 q9q/nBlc2wJvo/IsuvzdFRH+uJPvK5Of12KzliesN0ERr85GAgJExhVWnG3iu678+ngA=;
Received: from m16.mail.126.com ([117.135.210.9])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vik1e-0004vX-KZ for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jan 2026 02:02:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=IRNTD8aA6LWMkBMmEmDIcJ/0jijgrN8LtcD50K0ogEA=;
 b=Nx4pyAPgBv7H6dGwm8O6LJn2KVwHH1wttqzEWPDdL4UhaSvAPhcP9sduZ6Gqik
 TuYT/2zi7Jc/fIAoDNlOR2xlrWzhbad6huReGTm4APXPPWpsS5zvU0An4OGf/5ro
 o9BafN/26dnOB/LOK9pbq3MBk6nk6yM7ft9bzc2PB+8xg=
Received: from [192.168.1.126] (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wDnb4AYhXFpypkZCA--.41574S2; 
 Thu, 22 Jan 2026 10:02:00 +0800 (CST)
Message-ID: <83419982-77ba-4dac-880e-bf59669a006f@126.com>
Date: Thu, 22 Jan 2026 10:02:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chao Yu <chao@kernel.org>, Barry Song <21cnbao@gmail.com>
References: <20260109024716.12047-1-chao@kernel.org>
 <CAGsJ_4wjXMXk4YKsYebmtTa5dKVO21b91ieY=foYULWS+DyroQ@mail.gmail.com>
 <2cdd4281-7e37-4dd0-91b1-1ab16ef772aa@kernel.org>
 <CAGsJ_4weE5T1uBA1-JoJdbZY4E91eN_OL3hMdqixLcoKSrmuzw@mail.gmail.com>
 <8c13ca69-a08a-41c7-bbef-0a79a5f44f93@kernel.org>
Content-Language: en-US
From: Nanzhe Zhao <nzzhao@126.com>
In-Reply-To: <8c13ca69-a08a-41c7-bbef-0a79a5f44f93@kernel.org>
X-CM-TRANSID: _____wDnb4AYhXFpypkZCA--.41574S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryDGw47tFy7ZFW8Gr43trb_yoW8JFyxpa
 15C3s5Kr95GF4FkFykt3WfXryFqrWrtayUJa97WF97A3W5u34SkF1kt3WIkFyktrs7Cr48
 Ja1UWryUWFZ5JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0oGQUUUUU=
X-Originating-IP: [58.240.165.118]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBohke7WlxhRleRQAA3X
X-Headers-End: 1vik1e-0004vX-KZ
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to prevent clearing immutable for
 large folio supported inode
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGkgYWxsOgoK5ZyoIDIwMjYvMS85IDE2OjQ0LCBDaGFvIFl1IHZpYSBMaW51eC1mMmZzLWRldmVs
IOWGmemBkzoKCj4gdy8gYWJvdmUgbG9ja3MsIGl0IHNlZW1zIHRoZXJlIGlzIHN0aWxsIGEgcmFj
ZSBjb25kaXRpb24gYXMgYmVsb3c6Cj4gCj4gZjJmc19maWxlYXR0cl9zZXTCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmVhZAo+ICDCoC0gZjJmc19zZXRmbGFnc19jb21tb24KPiAgwqAg
LSB0cnVuY2F0ZV9wYWdlY2FjaGUKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAtIGYyZnNfcmVhZF9kYXRhX2xhcmdlX2ZvbGlvCj4gIMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgOiByZWFkIGxhcmdlIGZvbGlvcwo+
ICDCoCAtIG1hcHBpbmdfc2V0X2ZvbGlvX29yZGVyX3JhbmdlCj4gCj4gVGhhbmtzLAoKSSBub3Rp
Y2VkIHRoYXQgdGhlIGNvbW1lbnQgZm9yIGBtYXBwaW5nX3NldF9mb2xpb19vcmRlcl9yYW5nZSgp
YCBzYXlzOgoKPiAiQ29udGV4dDogVGhpcyBzaG91bGQgbm90IGJlIGNhbGxlZCB3aGlsZSB0aGUg
aW5vZGUgaXMgYWN0aXZlIGFzIGl0IGlzIG5vbi1hdG9taWMuIgoKSSdtIG5vdCBzdXJlIHdoZXRo
ZXIgY2FzZXMgbGlrZSBmMmZzX2ZpbGVhdHRyX3NldCBmYWxscyBpbnRvIHRoZSBpbm9kZSAKYWN0
aXZlIGNhc2UuCgo+Pgo+Pgo+PiBJZiBjbGVhcmluZyBpbW11dGFibGUgaXMgaW5kZWVkIHJhcmUs
IHdlIG1heSBsZWF2ZSB0aGlzIGFzIGlzLCBzaW5jZQo+PiB3cml0ZXMgYXJlIG5vdCBzdXBwb3J0
ZWQgdW50aWwgdGhlIHBhZ2UgY2FjaGUgaXMgZnVsbHkgZHJvcHBlZC4KPj4gRXZlbnR1YWxseSwg
d2Ugd2lsbCBzdXBwb3J0IGxhcmdlIGZvbGlvcyBvbiBub24taW1tdXRhYmxlIGZpbGVzLgo+Pgo+
PiBUaGFua3MKPj4gQmFycnkKCkFsc28sIEkgY291bGRu4oCZdCBmaW5kIGFueSBBUEkgaW4gYGlu
Y2x1ZGUvbGludXgvcGFnZW1hcC5oYCB0aGF0IGNhbiAKYXRvbWljYWxseSBzZXQgdGhlCmZvbGlv
IG9yZGVyIHJhbmdlLiBIb3dldmVyLCBJIHRoaW5rIGR5bmFtaWNhbGx5IHNldHRpbmcgbGFyZ2Ug
Zm9saW8gCm9yZGVyIHdoaWxlIGFuIGlub2RlCmlzIGFjdGl2ZSBpcyBhIHJlYXNvbmFibGUgcmVx
dWlyZW1lbnQuIEluIG15IG5vbiBpbW11dGFibGUgZmlsZSBsYXJnZSAKZm9saW8gd3JpdGUgd29y
aywgSSBuZWVkIHRvIGVuYWJsZSBsYXJnZSBmb2xpbyBzdXBwb3J0IGZvciBhIGZpbGUgd2hlbiAK
aXQgaXMgY29udmVydGVkIGZyb20gYW4gaW5saW5lIGZpbGUgdG8gYSBub24taW5saW5lIGZpbGUu
IFRoZSBsYWNrIG9mIGFuIAphdG9taWMgQVBJIHNlZW1zIHRvIGJlIGEgYmxvY2tlciBmb3IgbW92
aW5nIGxhcmdlIGZvbGlvIHdyaXRlIGZvcndhcmQuCkFueSBpZGVhIG9uIHRoYXQ/CgpUaGFua3Ms
Ck5hbnpoZSBaaGFvCgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9s
aXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
