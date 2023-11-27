Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14CEC4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Nov 2023 16:02:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r7e3f-0001vR-Gk;
	Mon, 27 Nov 2023 16:02:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiederm@xmission.com>) id 1r7e3a-0001uy-EJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Nov 2023 16:01:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Subject:Content-Type:MIME-Version:Message-ID:
 In-Reply-To:Date:References:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MnIsW2gRlEkCMgJZdG09I4YKTZY6znkqa+JAZFPAg/o=; b=A+sYll0MV9YSVA5xCARRv0US49
 l2JFlD3olQAUGbnU5PGOpKv7yKp8n2IlmKPqYFSUKAEOm5inTFiCmgNtuZXOVCLKP34DzUZa2r0zW
 hvF38Y0hQwDwOnxXp0aFouk1os8CBKHu87YJBl870IZOZkthThDX+GeSrQXylKauTiSU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Subject:Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:References:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MnIsW2gRlEkCMgJZdG09I4YKTZY6znkqa+JAZFPAg/o=; b=YkSKxS5cpVrofTuf0zCCUVws2B
 Lfzay1hxnHdnkgJvgwykqh030tlhx0C3k76RPtxyHgublII+70gKK8hiMgORbU4apBJgPDSdFgX/K
 +QqlmIIxQHkNKkRSecH8QHmeij9bV0JuD580jbYg1EDqDFJb1wp6GXHR1sE23QffmJz4=;
Received: from out02.mta.xmission.com ([166.70.13.232])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r7e3W-00H7MM-P3 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Nov 2023 16:01:58 +0000
Received: from in01.mta.xmission.com ([166.70.13.51]:53182)
 by out02.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1r7e3M-00Ahie-5g; Mon, 27 Nov 2023 09:01:44 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:51768
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in01.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1r7e3K-006NOb-0n; Mon, 27 Nov 2023 09:01:43 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Al Viro <viro@zeniv.linux.org.uk>
References: <20231121022734.GC38156@ZenIV> <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <20231123171255.GN38156@ZenIV> <20231123182426.GO38156@ZenIV>
 <20231123215234.GQ38156@ZenIV> <20231125220136.GB38156@ZenIV>
 <20231126045219.GD38156@ZenIV> <20231126184141.GF38156@ZenIV>
 <20231127063842.GG38156@ZenIV>
 <87jzq3nqos.fsf@email.froward.int.ebiederm.org>
Date: Mon, 27 Nov 2023 10:01:34 -0600
In-Reply-To: <87jzq3nqos.fsf@email.froward.int.ebiederm.org> (Eric
 W. Biederman's message of "Mon, 27 Nov 2023 09:47:47 -0600")
Message-ID: <878r6jnq1t.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1r7e3K-006NOb-0n; ; ;
 mid=<878r6jnq1t.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in01.mta.xmission.com; ; ; ip=68.227.168.167; ; ;
 frm=ebiederm@xmission.com; ; ; spf=pass
X-XM-AID: U2FsdGVkX18LzyKBjPL9+mOeggwlTuuNaPzk+DvVEcQ=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-Headers-End: 1r7e3W-00H7MM-P3
Subject: Re: [f2fs-dev] fun with d_invalidate() vs. d_splice_alias() was Re:
 [PATCH v6 0/9] Support negative dentries on case-insensitive ext4 and f2fs
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
Cc: Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
 Miklos Szeredi <miklos@szeredi.hu>, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Gabriel Krisman Bertazi <gabriel@krisman.be>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> I am confused what is going on with ext4 and f2fs.  I think they
> are calling d_invalidate when all they need to call is d_drop.

ext4 and f2f2 are buggy in how they call d_invalidate, if I am reading
the code correctly.

d_invalidate calls detach_mounts.

detach_mounts relies on setting D_CANT_MOUNT on the top level dentry to
prevent races with new mounts.

ext4 and f2fs (in their case insensitive code) are calling d_invalidate
before dont_mount has been called to set D_CANT_MOUNT.

Eric



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
