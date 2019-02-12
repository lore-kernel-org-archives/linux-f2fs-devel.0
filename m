From: Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: Proposal: Yet another possible fs-verity interface
Date: Tue, 12 Feb 2019 08:06:52 -0500
Message-ID: <1549976812.12743.225.camel@linux.ibm.com>
References: <20190207031101.GA7387@mit.edu>
 <CAHk-=wh2j+Yy28H_QxEdsP=k9xcHxjCG1PqKAF2Uv=ckK8oPug@mail.gmail.com>
 <1549807615.12743.109.camel@linux.ibm.com> <20190212053123.GR23000@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zohar@linux.ibm.com>) id 1gtXmQ-0000B9-IJ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Feb 2019 13:07:18 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gtXmO-002soT-GG
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Feb 2019 13:07:18 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1CCwuDx059451
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 12 Feb 2019 08:07:10 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qkwpwk3re-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 12 Feb 2019 08:07:10 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <zohar@linux.ibm.com>;
 Tue, 12 Feb 2019 13:07:08 -0000
In-Reply-To: <20190212053123.GR23000@mit.edu>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Eric Biggers <ebiggers@kernel.org>, "Darrick J.
 Wong" <darrick.wong@oracle.com>, Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

SGkgVGVkLAoKVGhlIGNvbnRleHQgZm9yIG15IGNvbW1lbnRzL3F1ZXN0aW9ucyB3YXMgTGludXMn
IHN1Z2dlc3Rpb25zLCB3aGljaAp5b3UndmUgcmVtb3ZlZC4KCk9uIFR1ZSwgMjAxOS0wMi0xMiBh
dCAwMDozMSAtMDUwMCwgVGhlb2RvcmUgWS4gVHMnbyB3cm90ZToKPiBPbiBTdW4sIEZlYiAxMCwg
MjAxOSBhdCAwOTowNjo1NUFNIC0wNTAwLCBNaW1pIFpvaGFyIHdyb3RlOgo+ID4gRm9yIHdoaWNo
IGZpbGVzIHdpbGwgdGhlIE1lcmtsZSB0cmVlIGJlIGNyZWF0ZWQ/ICBJcyB0aGlzIGZvciBhbGwK
PiA+IGZpbGVzIG9uIGEgcGVyIGZpbGUgc3lzdGVtIGJhc2lzPyDCoE9yIGlzIHRoZXJlIHNvbWUg
c29ydCBvZiAiZmxhZyIgb3IKPiA+IHBvbGljeT8gIFRoZSBvcmlnaW5hbCBkZXNpZ24gd2FzIGJh
c2VkIG9uIGFuIGlvY3RsIGVuYWJsaW5nL2Rpc2FibGluZwo+ID4gYSBmbGFnLiBJbiB0aGlzIG5l
dyBkZXNpZ24sIGlzIHRoZXJlIHN0aWxsIGFuIGlvY3RsPwo+IAo+IFNvIGZvciBvdXIgZmlyc3Qg
dXNlIGNhc2UsIGl0IHdpbGwgYmUgdXNlZCBmb3IgInByaXZpbGVnZWQgQVBLIGZpbGVzIgo+IGlu
IEFuZHJvaWQuICBZb3UgY2FuIHRoaW5rIG9mIHRoaXMgYXMgYSAic2V0dWlkIGJpbmFyeSIsIGVm
ZmVjdGl2ZWx5LgoKWWVzLCBJIHVuZGVyc3RhbmQgdGhhdCB5b3VyIHByaW1hcnkgZ29hbCBoYXNu
J3QgY2hhbmdlZC7CoMKgTGludXMgd2FzCnN1Z2dlc3RpbmcgInRoZSBpbnRlcmZhY2UgYmUgbWFk
ZSBpZGVtcG90ZW50IiB0byBzdXBwb3J0ICJmaWxlc3lzdGVtcwp0aGF0IGRvbid0IGFjdHVhbGx5
IGhhdmUgYW55IGxvbmctdGVybSBzdG9yYWdlIG1vZGVsIGZvciB0aGUgbWVya2xlCnRyZWUuIMKg
SU9XLCB5b3UgY291bGQgZG8gdGhlIG1lcmtsZSB0cmVlIGNhbGN1bGF0aW9uIChhbmQKdmVyaWZp
Y2F0aW9uKSBldmVyeSB0aW1lIGF0IGJvb3R1cCIuIMKgSW4gdGhhdCBjb250ZXh0LCBJIGFza2Vk
IHdoZXRoZXIKdGhlIE1lcmtsZSB0cmVlIGZpbGUgaGFzaCB3b3VsZCBiZSBmb3IgZXZlcnkgZmls
ZSBvbiB0aGUgZmlsZXN5c3RlbSBvcgpub3QsIGFuZCBob3cgdG8gaWRlbnRpZnkgdGhvc2UgZmls
ZXMuCgo+ID4gVGhlIGV4aXN0aW5nIGZpbGUgaGFzaGVzIGluY2x1ZGVkIGluIHRoZSBtZWFzdXJl
bWVudCBsaXN0IGFuZCB0aGUKPiA+IGF1ZGl0IGxvZywgYXJlIGN1cnJlbnRseSBiZWluZyB1c2Vk
IGZvciByZW1vdGUgYXR0ZXN0YXRpb24sIGZvcmVuc2ljcwo+ID4gYW5kIHNlY3VyaXR5IGFuYWx5
dGljcy4KCkFnYWluLCB0aGUgY29udGV4dCBmb3IgdGhpcyBjb21tZW50IHdhcyBMaW51cycgc3Vn
Z2VzdGlvbiAiZWFjaCBsZXZlbApvZiB0aGUgbWVya2xlIHRyZWUgbmVlZHMgdG8gaGF2ZSBhIGhh
c2ggc2VlZGluZyB0aGluZyBvciB3aGF0ZXZlci4iClVwIHRvIHRoaXMgcG9pbnQsIEkgaGFkIGFz
c3VtZWQgdGhlIE1lcmtsZSB0cmVlIGZpbGUgcm9vdCBoYXNoIGNvdWxkCmJlIHVzZWQgYXMgYW4g
aWRlbnRpZmllciwgc2ltaWxhciB0byB0aGUgZmlsZSBoYXNoLsKgwqBXaXRoIGhpcwpzdWdnZXN0
aW9uLCBpdCBzb3VuZHMgbGlrZSB0aGUgTWVya2xlIHRyZWUgZmlsZSByb290IGhhc2ggd291bGQg
YmUKc3lzdGVtIGRlcGVuZGVudCwgbWFraW5nIGl0IHVzZWxlc3MgZm9yIHRoZSBhYm92ZSB1c2Fn
ZXMuCgo+IAo+IElNQSBoYXMgYSB2ZXJ5IGRpZmZlcmVudCBzZXQgcHJpbWFyeSB1c2UgY2FzZXMg
dGhhbiBmc3Zlcml0eS4KCldlIG5lZWQgdG8gZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIElNQSdzIG1l
dGhvZCBvZiBjYWxjdWxhdGluZyB0aGUgZmlsZQpoYXNoIGZyb20gdGhlIElNQSBtZWFzdXJlbWVu
dCBsaXN0LiDCoEkgdG90YWxseSBhZ3JlZSB0aGVyZSBpcyBhIHBsYWNlCmZvciBib3RoIG1ldGhv
ZHMgb2YgY2FsY3VsYXRpbmcgdGhlIGZpbGUgaGFzaC4gwqBJIGFtIGhvcGluZyB0aGF0IHdlCndv
dWxkIGJlIGFibGUgdG8gdXNlIHRoZSBNZXJrbGUgdHJlZSBmaWxlIHJvb3QgaGFzaCBpbiB0aGUg
SU1BCm1lYXN1cmVtZW50IGxpc3QuIMKgSXQgbWFrZXMgbm8gc2Vuc2UgdG8gaGF2ZSB0byBjYWxj
dWxhdGUgdGhlIGZpbGUKaGFzaCBmb3IgdGhlIG1lYXN1cmVtZW50IGxpc3QsIGlmIHlvdSdyZSB1
c2luZyBmcy12ZXJpdHkuCgpNaW1pCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMt
ZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0
L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
