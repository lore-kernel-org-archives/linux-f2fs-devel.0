Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81053C77B73
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 May 2023 06:56:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q3tHe-0006vU-24;
	Tue, 30 May 2023 06:56:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hare@suse.de>) id 1q3tHc-0006vO-MQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 May 2023 06:56:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VFK3SohUUDN10n3pe8MLPSQXqWJ4uP6V3M6LkcuIOgc=; b=ApiKLTCgaqDapj9Up2FofcWKF0
 qz3jtEZD4pXRhzbKFV+7dhxUagK/Kx1UUyABxbSLa6GBZgzwJuIi66Vg8/YujkLs89e7uasIhhqW8
 i8FOi/lTVuRKG9GeSmTlzIHuE4RzswwDlzBPL1OVQjiySPwRQNJDgoC7UfJuKnxEB5iU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VFK3SohUUDN10n3pe8MLPSQXqWJ4uP6V3M6LkcuIOgc=; b=aWL0T6wfJ7KhipZSYtJj/r4U2X
 fDT7ZxmhLymGMFqsi8rjOLvLTycQWmYe3UVtQzwf9sWsqvisdQDL5RMFTG1hbUCSrZDNpbJfnothL
 zSwyBDDdQ//0C+YrxpFg/a6Hk7YH2v5upSCFUTAIt0k2JE4/i0wVbWrX/j4GxqOpSGVU=;
Received: from smtp-out1.suse.de ([195.135.220.28])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1q3tHa-0003x3-0r for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 May 2023 06:56:41 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E4BA221AE6;
 Tue, 30 May 2023 06:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1685429788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFK3SohUUDN10n3pe8MLPSQXqWJ4uP6V3M6LkcuIOgc=;
 b=BEwBqtYKw8R4m/lHQ0XnhY55aIGS6lAcyrUzUI9aFjXL9w601wGVeMShHaYtzooyqtx08o
 WBz5Y4sPhrFWSXhXd8qdCFcTfB4sRCJRp5EuRdP1ofH/W0jYtS5E0ajYBwjI9InuX4ByYB
 f+LGLxb1CPqcWfcjEQtMhYyyF9KFIjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1685429788;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFK3SohUUDN10n3pe8MLPSQXqWJ4uP6V3M6LkcuIOgc=;
 b=4If++VChQ1Ct3zqwYasnvDL5rZBrqUF5Jnh+HPXBX6xmZB8HXA7q4r1iU3wRgMuO++GuO6
 vzFSEjsX/sWutoCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 513861341B;
 Tue, 30 May 2023 06:56:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id rcW0ERyedWTAcQAAGKfGzw
 (envelope-from <hare@suse.de>); Tue, 30 May 2023 06:56:28 +0000
Message-ID: <53963459-faeb-3d96-bc98-7a2bfc8507d0@suse.de>
Date: Tue, 30 May 2023 08:56:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
References: <20230524063810.1595778-1-hch@lst.de>
 <20230524063810.1595778-2-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230524063810.1595778-2-hch@lst.de>
X-Headers-End: 1q3tHa-0003x3-0r
Subject: Re: [f2fs-dev] [PATCH 01/11] backing_dev: remove
 current->backing_dev_info
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
 Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 cluster-devel@redhat.com, Ilya Dryomov <idryomov@gmail.com>,
 linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gNS8yNC8yMyAwODozOCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gVGhlIGxhc3QgdXNl
ciBvZiBjdXJyZW50LT5iYWNraW5nX2Rldl9pbmZvIGRpc2FwcGVhcmVkIGluIGNvbW1pdAo+IGI5
YjEzMzVlNjQwMyAoInJlbW92ZSBiZGlfY29uZ2VzdGVkKCkgYW5kIHdiX2Nvbmdlc3RlZCgpIGFu
ZCByZWxhdGVkCj4gZnVuY3Rpb25zIikuICBSZW1vdmUgdGhlIGZpZWxkIGFuZCBhbGwgYXNzaWdu
bWVudHMgdG8gaXQuCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBs
c3QuZGU+Cj4gLS0tCj4gICBmcy9idHJmcy9maWxlLmMgICAgICAgfCA2ICstLS0tLQo+ICAgZnMv
Y2VwaC9maWxlLmMgICAgICAgIHwgNCAtLS0tCj4gICBmcy9leHQ0L2ZpbGUuYyAgICAgICAgfCAy
IC0tCj4gICBmcy9mMmZzL2ZpbGUuYyAgICAgICAgfCAyIC0tCj4gICBmcy9mdXNlL2ZpbGUuYyAg
ICAgICAgfCA0IC0tLS0KPiAgIGZzL2dmczIvZmlsZS5jICAgICAgICB8IDIgLS0KPiAgIGZzL25m
cy9maWxlLmMgICAgICAgICB8IDUgKy0tLS0KPiAgIGZzL250ZnMvZmlsZS5jICAgICAgICB8IDIg
LS0KPiAgIGZzL250ZnMzL2ZpbGUuYyAgICAgICB8IDMgLS0tCj4gICBmcy94ZnMveGZzX2ZpbGUu
YyAgICAgfCA0IC0tLS0KPiAgIGluY2x1ZGUvbGludXgvc2NoZWQuaCB8IDMgLS0tCj4gICBtbS9m
aWxlbWFwLmMgICAgICAgICAgfCAzIC0tLQo+ICAgMTIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAzOCBkZWxldGlvbnMoLSkKPiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8
aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAg
ICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNv
bHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChB
RyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogSXZvIFRvdGV2LCBBbmRyZXcKTXllcnMs
IEFuZHJldyBNY0RvbmFsZCwgTWFydGplIEJvdWRpZW4gTW9lcm1hbgoKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxp
bmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xp
c3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
