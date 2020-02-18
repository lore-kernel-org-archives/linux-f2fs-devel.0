Return-Path: <SRS0=tJjq=4G=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E35BC34026
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:31:04 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E0B422527
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="JgNbKuuq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="meyZNQHK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JW7mAbAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0B422527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j409f-0000Ta-QZ; Tue, 18 Feb 2020 10:31:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1j409e-0000T9-7S; Tue, 18 Feb 2020 10:31:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C2o90FN+lYrxm2KJJmFH4raJjnf6GoUSpnkFMK+Qcro=; b=JgNbKuuqDbgS6hVUMQVNqFm0rD
 derZ0pIm/lo02KLWgUsH1TviDh6HidZ3bYTODXDp/yY/H/AdrkuBj3eP9ANkhOwElRmF0uDBJom4m
 Eh1hl19s9Y6UsilSkqArJoldgIlZ+C55hGGwcFSa/9PH+/xIo8I0QfKaosGqHRH8knXc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C2o90FN+lYrxm2KJJmFH4raJjnf6GoUSpnkFMK+Qcro=; b=meyZNQHKKJz8w1KKGi7AHptE1Q
 1HDWRhppvIiY8F2AtX3Xcbe/0v2xNOMXgV57sgmZ5Wjt0G0BkaxnDsqFcjhAtfyQmXA/UTWUv/P1/
 h/HbtLbcMKGqb28iOo64irPxaZiCbajyUd/bRY/drCkh3d102+NsUv2lyOqCXKCwoJtA=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j409a-007F95-Gk; Tue, 18 Feb 2020 10:31:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-ID:Content-Description;
 bh=C2o90FN+lYrxm2KJJmFH4raJjnf6GoUSpnkFMK+Qcro=; b=JW7mAbAg6lbo1bL53ycPS77Cxv
 +MLnbJE6iQdWjaZ/ZMQtBT4d5xI7ZfBe0jj9AM/3Az0BZ5D6TOTzznCqOwKZXZTcgdp1X+eSieBqc
 VVKE0uh8a4LVnEgkF4YFwy21CZDCqVOPRsleosusMz+hEOs+w6P3pRQgN5xh4dmD9g9QDKzX15gOs
 S1x/SdaDSCSBwBxc9ZHclEoPjDPKTtrfDJuzeltqGX/xLhjJCH+SGTd0rwmWrSqd+HnYLgIRzcc9P
 UO7+Z23IOWkEgiqrVOBz8ATI0V2l7V31VZc/I63E5kUwpbMuacZlBjVJobrR1l3a0giQmF2taF9Mj
 zaaRnUBA==;
Received: from ip-109-41-129-189.web.vodafone.de ([109.41.129.189]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j3zjq-0002gZ-Vj; Tue, 18 Feb 2020 10:04:23 +0000
Date: Tue, 18 Feb 2020 11:04:06 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20200218110406.098fdc09@kernel.org>
In-Reply-To: <20200218040146.GM7778@bombadil.infradead.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
 <20200218040146.GM7778@bombadil.infradead.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Headers-End: 1j409a-007F95-Gk
Subject: Re: [f2fs-dev] [PATCH 00/44] Manually convert filesystem FS
 documents to ReST
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
Cc: Latchesar Ionkov <lucho@ionkov.net>,
 Martin Brandenburg <martin@omnibond.com>, Jan Kara <jack@suse.cz>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Amir Goldstein <amir73il@gmail.com>, Bob Copeland <me@bobcopeland.com>,
 David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>,
 linux-mtd@lists.infradead.org, Ilya Dryomov <idryomov@gmail.com>,
 linux-afs@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Christoph Hellwig <hch@infradead.org>,
 linux-nilfs@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>,
 Sage Weil <sage@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Richard Weinberger <richard@nod.at>, Tyler Hicks <code@tyhicks.com>,
 cluster-devel@redhat.com, v9fs-developer@lists.sourceforge.net,
 Gao Xiang <xiang@kernel.org>, linux-ext4@vger.kernel.org,
 Salah Triki <salah.triki@gmail.com>, Alexey Dobriyan <adobriyan@gmail.com>,
 devel@lists.orangefs.org, Eric Van Hensbergen <ericvh@gmail.com>,
 ecryptfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Bob Peterson <rpeterso@redhat.com>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 ceph-devel@vger.kernel.org, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Anton Altaparmakov <anton@tuxera.com>, Damien Le Moal <damien.lemoal@wdc.com>,
 Luis de Bethencourt <luisbg@kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
 linux-ntfs-dev@lists.sourceforge.net, Jeff Layton <jlayton@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
 Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org,
 Phillip Lougher <phillip@squashfs.org.uk>, Johannes Thumshirn <jth@kernel.org>,
 linux-erofs@lists.ozlabs.org, linux-karma-devel@lists.sourceforge.net,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Em Mon, 17 Feb 2020 20:01:46 -0800
Matthew Wilcox <willy@infradead.org> escreveu:

> On Mon, Feb 17, 2020 at 05:11:46PM +0100, Mauro Carvalho Chehab wrote:
> > There are lots of plain text documents under Documentation/filesystems.
> > 
> > Manually convert several of those to ReST and add them to the index file.  
> 
> I think at least 90% of this material needs to be in admin-guide.  Should
> we create Documentation/admin-guide/filesystems/ and move most of these
> files there?

It makes sense to me. Yet, there are some of those files that contains
both user-facing and kernel-facing docs at the same place. 

Btw, I found the same pattern on *several* other subsystems: when
someone is documenting some feature, it tends to document both kAPI,
uAPI and admin.

Right now, what we did so far on most places were to keep the stuff 
together, as splitting them could sometimes be painful.

As we are too close to finish the ReST conversion[1], I would prefer to
first finish it. 

Then, do a second pass at files outside the new directories (like
admin-guide), in order to better organize things, eventually splitting
some files into kAPI, uAPI and/or admin-guide.

[1] Looking at next-20200217, after my last doc patches applied on this tree:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=all_docs_merged

excluding (most) false positives, we have now only ~50 text files left to
convert:

$ dirname $(find Documentation/ -type f|grep -vE '\.(rst|svg|dot|py|awk|sh|pl|gitignore|S|yaml|c|inf|vim|modes)'|grep -vE '(Makefile|Kconfig|LICENSE|COPYING-logo|ChangeLog|CREDITS)'|grep -v devicetree/bindings|grep -vE 'Documentation/(ABI|features|output|SubmittingPatches|CodingStyle|logo.gif|dontdiff|sphinx/requirements.txt|admin-guide/kdump/gdbmacros.txt|admin-guide/aoe/udev.txt|EDID/hex|netlabel/draft-ietf-cipso-ipsecurity-01.txt|firmware_class/hotplug-script|target/target-export-device|networking/mac80211-auth-assoc-deauth.txt|sparc/oradax/dax-hv-api.txt)'|grep -v translations)|sort|uniq -c|sort -n
$ echo -n "Total: "
$ dirname $(find Documentation/ -type f|grep -vE '\.(rst|svg|dot|py|awk|sh|pl|gitignore|S|yaml|c|inf|vim|modes)'|grep -vE '(Makefile|Kconfig|LICENSE|COPYING-logo|ChangeLog|CREDITS)'|grep -v devicetree/bindings|grep -vE 'Documentation/(ABI|features|output|SubmittingPatches|CodingStyle|logo.gif|dontdiff|sphinx/requirements.txt|admin-guide/kdump/gdbmacros.txt|admin-guide/aoe/udev.txt|EDID/hex|netlabel/draft-ietf-cipso-ipsecurity-01.txt|firmware_class/hotplug-script|target/target-export-device|networking/mac80211-auth-assoc-deauth.txt|sparc/oradax/dax-hv-api.txt)'|grep -v translations)|wc -l

      1 Documentation/filesystems/cifs
      1 Documentation/filesystems/configfs
      1 Documentation/scsi
      1 Documentation/virt/kvm/devices
      2 Documentation/admin-guide
      3 Documentation
      6 Documentation/devicetree
      6 Documentation/filesystems/caching
      8 Documentation/RCU
     21 Documentation/filesystems
Total: 50

Once we get this series merged, I'm planning to prepare and submit a second
series doing the conversion for the other ~20 filesystem files.

Btw, if you want to look how things will become after my patch series,
I'm keeping a html build after all my patch series at:

	https://www.infradead.org/~mchehab/kernel_docs/

Cheers,
Mauro


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
