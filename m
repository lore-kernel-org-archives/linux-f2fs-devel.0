Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB8EC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SuProDsuDqD1iCUJJZfCYi9kecQLAo0G79oNzNqlVpY=; b=aMc65JeESrVsuWpRda8WjdA//9
	9wPZuD19/NNFh+Joplb2Khaa+Vm8jNhVFulDd9zSNX3aCByxc5ow6HqX+jjN9d9jfQrJyYyaDtf+7
	ohmh5Uz+wX6WhVW69l31n1RaYvkCdmVFMOpFpkSQ3MffzZCslxwipB/gPPyna+7dQsgY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wfbHC-0008D2-HP;
	Fri, 03 Jul 2026 10:37:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1wfbHB-0008Cw-KK
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 03 Jul 2026 10:37:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:References:In-Reply-To:Cc:To:From:
 Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ibq5yGoOYYUKiAiXchC0WA0gL3l+/26cw0R84LkFjaY=; b=kXzTodc+JbCE4mzJhyCztjvh3L
 E0NQYaNw0iPSxQ459c1LDmhGYFKceQ0FsxLgxtLL92UFqoqqtTVr9HpfIc0wsD25vOhGIj7goa3c/
 9CM7BmjUQJZF9rj7TlgyrRvJ1Mng23LPFXNgRLWfDSRhUUnEL+VCApRXqLwpc7/qbiNE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Message-Id:Date:References:In-Reply-To:Cc:To:From:Subject:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ibq5yGoOYYUKiAiXchC0WA0gL3l+/26cw0R84LkFjaY=; b=b0h+lHIA7mDtecT4V8jHu/3/QA
 gXloxv8XX/DTWR9nd1I+fYRgxSHTDgRXKh05Tbor8z4CLQCrOkdkAbk+Ah3bmL7lGj99Ahe3raafA
 wt4ah1qSOEp4a4khy0rJNNlxq3XrIIbaRj9E8BdAzbV/4sqDWFrwyNyc5toXmsimP1ek=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfbH7-0002xz-Vo for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 03 Jul 2026 10:37:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B4B7601C2;
 Fri,  3 Jul 2026 10:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CFA1F000E9;
 Fri,  3 Jul 2026 10:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783075047;
 bh=ibq5yGoOYYUKiAiXchC0WA0gL3l+/26cw0R84LkFjaY=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=W8LzFtRDEJ+LA4ga+f6QzIP5wIjhPrvbgSkeN5H9fdUp8ldRpYac+VP2pbFWqLIaZ
 VOZRYcIErzh7ZZVI1opgKNPyPdXZNYzLlXZRZvIfpIEGsP8CRSvmh6dp1f1DUAQ8eT
 REmssNKn6FgP95Nylwk1jyDskOejoq/ZtxJV6+SZMcueW6AmnmkTRlSc0afIY2ZaY4
 0j6EQgUmekHKxLsbkP1RtsOiATrm0qsMc/rLKl6p2+xyg60HQXm8THGcRmHmGEbsA5
 +KIVTrOUxI8EdD77tZ08aAlBNDaVgctnhdPNMu6u++MTrLUeeidjuDh4Pwu7QdGwKu
 L34A4eoQ9xeiA==
MIME-Version: 1.0
To: Joanne Koong <joannelkoong@gmail.com>
In-Reply-To: <CAJnrk1b8j5WHtbHOWNXc4=QBFOxde1f2QxTOeui7Ta8O-xWcTA@mail.gmail.com>
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
 <20260701000949.1666714-18-joannelkoong@gmail.com>
 <20260702140705.GE21339@lst.de> <20260702165117.GK9392@frogsfrogsfrogs>
 <CAJnrk1b8j5WHtbHOWNXc4=QBFOxde1f2QxTOeui7Ta8O-xWcTA@mail.gmail.com>
Date: Fri, 03 Jul 2026 12:37:14 +0200
Message-Id: <20260703-nachrangig-gegeben-befestigen-8219a53648c7@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=brauner@kernel.org;
 h=from:subject:message-id; bh=d4s4dMLniDIuK4LTsTNvbrHzQ5sC7wrFJBhb2lMg/u0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5T7iz7fS6t1kzwm8fcparv3KDyXRbpMKKF15fNPbwT
 dVe5OMk1lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRtgxGhmMbHf76zT147eA7
 nZiMnzu9Q+v+PNtl5pjYUP6f6/XP/z8YGe7siubVVw14xJBz7G+cn2VOrNK0S08/rfgQ3Ddj8wq
 eCi4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Headers-End: 1wfbH7-0002xz-Vo
Subject: Re: [f2fs-dev] [PATCH v2 17/18] iomap: pass iomap_next_fn directly
 instead of struct iomap_ops
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
From: Christian Brauner via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: "Ritesh Harjani \(IBM\)" <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>,
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
 "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, Baokun Li <libaokun@linux.alibaba.com>,
 Chunhai Guo <guochunhai@vivo.com>, Dan Williams <djbw@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>, Yue Hu <zbestahu@gmail.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Zhang Yi <yi.zhang@huawei.com>,
 willy@infradead.org, Christoph Hellwig <hch@lst.de>,
 Yuezhang Mo <yuezhang.mo@sony.com>, hsiangkao@linux.alibaba.com,
 Gao Xiang <xiang@kernel.org>,
 "open list:EXT2 FILE SYSTEM" <linux-ext4@vger.kernel.org>,
 Namjae Jeon <linkinjeon@kernel.org>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Andreas Gruenbacher <agruenba@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 "open list:FUSE FILESYSTEM \[CORE\]" <fuse-devel@lists.linux.dev>,
 brauner@kernel.org, Johannes Thumshirn <jth@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>,
 "open list:NTFS3 FILESYSTEM" <ntfs3@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 linux-xfs@vger.kernel.org, "open list:GFS2 FILE SYSTEM" <gfs2@lists.linux.dev>,
 "open list:FILESYSTEM DIRECT ACCESS \(DAX\)" <nvdimm@lists.linux.dev>,
 Hongbo Li <lihongbo22@huawei.com>, linux-fsdevel@vger.kernel.org,
 Sungjong Seo <sj1557.seo@samsung.com>,
 "open list:EROFS FILE SYSTEM" <linux-erofs@lists.ozlabs.org>,
 "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyNi0wNy0wMiAxODo0NyAtMDcwMCwgSm9hbm5lIEtvb25nIHdyb3RlOgo+IE9uIFRodSwg
SnVsIDIsIDIwMjYgYXQgOTo1MeKAr0FNIERhcnJpY2sgSi4gV29uZyA8ZGp3b25nQGtlcm5lbC5v
cmc+IHdyb3RlOgo+ID4KPiA+IE9uIFRodSwgSnVsIDAyLCAyMDI2IGF0IDA0OjA3OjA1UE0gKzAy
MDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+ID4gPiBMb29rcyBnb29kOgo+ID4gPgo+ID4g
PiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Cj4gPiA+Cj4gPiA+
IEluIHRlcm1zIG9mIG1lcmdlIGxvZ2lzdGljcywgSSB3b25kZXIgaWYgd2Ugc2hvdWxkIGRlbGF5
IHRoaXMgYW5kCj4gPiA+IHRoZSBwcmV2aW91cyBwYXRjaCB0byB0aGUgbmV4dCBtZXJnZSB3aW5k
b3cgc28gdGhhdCB3ZSBjYW4gbWluaW1pemUgdGhlCj4gPiA+IGNyb3NzLXN1YnN5c3RlbSBtZXJn
ZSBwYWluIHdpdGggbW9yZSBmaWxlIHN5c3RlbSBpb21hcCBjb252ZXJzaW9uLgo+ID4gPiBJZiBu
b25lIG9mIHRoZW0gYWN0dWFsbHkgaGFwcGVuIHVudGlsIHJjNiBvciBzbywgb3JpZiAgdGhlIG1l
cmdlcyBhcmVuJ3QKPiA+ID4gcGFpbmZ1bCB3ZSBjb3VsZCBzdGlsbCBwaWNrIHRoZW0gdXAgbGF0
ZSBpbiB0aGUgbWVyZ2Ugd2luZG93Lgo+ID4KPiA+IEknZCBzYXkgZXZlcnl0aGluZyBidXQgdGhp
cyBwYXRjaCBzaG91bGQgZ28gaW4gZHVyaW5nIHRoZSBtZXJnZSB3aW5kb3cKPiA+IGZvciA3LjMs
IGFsb25nIHdpdGggY2xlYXIgaW5zdHJ1Y3Rpb25zIHRvIGJyYXVuZXIvdG9ydmFsZHMgdG8gZXhw
ZWN0Cj4gPiB0aGlzIHBhdGNoIHRvIGFwcGVhciByaWdodCBiZWZvcmUgNy4zLXJjMSBnZXRzIHRh
Z2dlZCwgdG8gY2xlYW4gdXAgYWxsCj4gPiB0aGUgb3RoZXIgY2hhbmdlcyB0aGF0IGNvbWUgaW4u
Cj4gCj4gSnVzdCB0byBjbGFyaWZ5LCBkaWQgeW91IG1lYW4gdGhpcyBwYXRjaCBhbmQgdGhlIHBy
ZXZpb3VzIG9uZT8gSWYgaSdtCj4gaW50ZXJwcmV0aW5nIENocmlzdG9waCdzIGNvbmNlcm4gY29y
cmVjdGx5LCBJIHRoaW5rIGhlJ3Mgd29ycmllZCBhYm91dAo+IG90aGVyIGZpbGVzeXN0ZW1zIGNv
bnZlcnRpbmcgdG8gaW9tYXAgdXNpbmcgdGhlIC0+aW9tYXBfYmVnaW4oKSAvCj4gLT5pb21hcF9l
bmQoKSBmdW5jdGlvbnMgc3RpbGw/IFRoYXQgc291bmRzIGxpa2UgYSBnb29kIHBsYW4gdG8gbWUs
IGZvcgo+IHYzIEknbGwgc3VibWl0IGV2ZXJ5dGhpbmcgYnV0IHRoaXMgcGF0Y2ggYW5kIHRoZSBs
YXN0IG9uZSBhbmQgdGhlbgoKT2ssIHNvIHdlJ2xsIGRvIHRoZSBwcmVwIGZvciB2ZnMtNy4zLmlv
bWFwIChha2EgdG8gYmUgbWVyZ2VkIGluIHRoZQp2Ny4zLXJjMSBjeWNsZSkuLi4KCj4gc3VibWl0
IHRoZXNlIHBhdGNoZXMgKGFuZCBhbnkgY2xlYW51cCBvbmVzIHRoYXQgYmVjb21lIG5lY2Vzc2Fy
eSkgdG8KPiBDaHJpc3RpYW4gcmlnaHQgYmVmb3JlIDcuMy1yYzEgZ2V0cyB0YWdnZWQgKHdoaWNo
IGFzIEkgdW5kZXJzdGFuZCBpdCwKPiBpcyB3aGVuIHRoZSBtZXJnZSB3aW5kb3cgaXMgYWJvdXQg
dG8gY2xvc2UpLgoKYW5kIG1lcmdlIHRoZXNlIF9hZnRlcl8gdjcuMy1yYzEgaGFzIGJlZW4gdGFn
Z2VkLi4uCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291
cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZv
L2xpbnV4LWYyZnMtZGV2ZWwK
