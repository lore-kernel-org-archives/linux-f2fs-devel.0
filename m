From: Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: Proposal: Yet another possible fs-verity interface
Date: Tue, 12 Feb 2019 09:44:39 -0500
Message-ID: <1549982679.12743.248.camel@linux.ibm.com>
References: <20190207031101.GA7387@mit.edu>
 <CAHk-=wh2j+Yy28H_QxEdsP=k9xcHxjCG1PqKAF2Uv=ckK8oPug@mail.gmail.com>
 <20190212051237.GQ23000@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zohar@linux.ibm.com>) id 1gtZJ6-0005NX-BB
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Feb 2019 14:45:08 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gtZJ3-00AWH4-PU
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Feb 2019 14:45:08 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1CEiLBB015236
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 12 Feb 2019 09:45:00 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qkww9pejr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 12 Feb 2019 09:44:59 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <zohar@linux.ibm.com>;
 Tue, 12 Feb 2019 14:44:57 -0000
In-Reply-To: <20190212051237.GQ23000@mit.edu>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Biggers <ebiggers@kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ext4@vger.kernel.org

PiBBdCB0aGF0IHBvaW50LCB0aGUgbWVya2xlIHRyZWUgdGhpbmcgZW5kcyB1cCBmYWlybHkgZXF1
aXZhbGVudCB0bwp0aGUKPiA+IElNQSAibWVhc3VyZW1lbnQiIHRoaW5nLCB3aXRoIHRoZSBleGNl
cHRpb24gdGhhdCB0aGUgZmlsZXN5c3RlbSAqbWF5Kgo+ID4gb3B0aW1pemUgaXQgdG8gYmUgbG9u
Zy10ZXJtLiBIbW0/Cj4gCj4gV2VsbCwgZXhjZXB0IHRoYXQgaXQncyBqdXN0IGEgbGVzcyBlZmZp
Y2llbnQgd2F5IG9mIGRvaW5nIElNQQo+ICJtZWFzdXJlbWVudCIgKGlmIHRoZSBmaWxlIHN5c3Rl
bSBkb2Vzbid0IHN1cHBvcnQgTWVya2xlIHRyZWUKPiBzdG9yYWdlKS4KPiAKPiBTbyBhZGRpbmcg
dGhhdCBjb21wbGV4aXR5IGlzLCBpbiBteSB2aWV3LCBub3QgcmVhbGx5IHdvcnRoIGl0LCBzaW5j
ZSBJCj4gdmVyeSBtdWNoIGRvdWJ0IGFueW9uZSB3b3VsZCB1c2UgYSBzbG93ZXIgc2NoZW1lLiAg
SSB0aGluayB0aGUgbXVjaAo+IGJldHRlciBtb2RlbCBpcyB0aGF0IGZzdmVyaXR5IGlzIGZvciBm
aWxlIHN5c3RlbSB3aGVyZSB5b3UgY2FuIHN0b3JlCj4gdGhlIE1lcmtsZSB0cmVlIChhbmQgaXQn
cyByZWFsbHkgbm90IHRoYXQgaGFyZCBmb3IgbW9zdCBmaWxlIHN5c3RlbXMKPiB0byBzdG9yZSBp
dCk7IGFuZCBpZiB5b3UgYXJlIHVzaW5nIGEgZmlsZSBzeXN0ZW0gd2hpY2ggZG9lc24ndCwgdXNl
Cj4gSU1BIGluIGdvb2QgaGVhbHRoLgoKVGVkLCBvbmUgb2YgdGhlIHByb2JsZW1zIHdpdGggSU1B
IGlzIHRoYXQgdGhlIGZpbGUgaGFzaC9zaWduYXR1cmUKdmVyaWZpY2F0aW9uIGlzIGF0IGZpbGUg
b3Blbi4gwqBJdCBpc24ndCBhd2FyZSB3aGVuIGZpbGVzIGFyZSBicm91Z2h0CmluIGZyb20gY2Fj
aGUuIMKgRG9lcyBmcy12ZXJpdHkgcmUtdmVyaWZ5IGJsb2NrcyBhcyB0aGV5J3JlIHJlc3RvcmVk
CmZyb20gY2FjaGU/IMKgRm9yIHNvbWUgdXNlIGNhc2VzLCB0aGF0IG1pZ2h0IGp1c3RpZnkgdGhl
IHVwIGZyb250IGNvc3QKYXNzb2NpYXRlZCB3aXRoIGJ1aWxkaW5nIHRoZSBNZXJrbGUgdHJlZS4K
Ck1pbWkKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8v
bGludXgtZjJmcy1kZXZlbAo=
