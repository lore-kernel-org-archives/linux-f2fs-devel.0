Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F18606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=V2rTCptw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Vsl0A+OE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FPSjUuYV;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFNJNicX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ioKZC8n5CKiGWu4bZvogff2eDMPxF5g6z3CyBF6xMLs=; b=V2rTCptwKyZ+STBeEwsmzrmiEh
	Q2QaWZAtHvHWKlvYdC7tZdR7IU51DiBU/S74XOXmlsnDZzplzSvX2MHbUPLWitHoDsJu+gPP1gvsl
	QZH8I89fxQxXi967XtnzNOFt852iQOtlO64o9fbpIC03TeP4FgAaTEyllSqaBvvm+IxM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLFpX-000000003s9-3mxp;
	Mon, 26 Oct 2026 08:13:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <brauner@kernel.org>) id 1xLFp4-000000003nf-2Rxc
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 08:12:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=twvo2S5XjbqEkOWkAQpnGbrW91qUdbVnGPc73sw06G4=; b=Vsl0A+OE8krLettmqglByvSzOw
 Q0ooNzSYwQswV7wBCVT2KLeHShv2epqJRI+uOdqWwdwuRQC800viEwDnBmx+sBjcZVKEMh7sZSXJz
 5NvLRF2oAiruIbc5EYZrF2VTOTf0NDpqcSAkNNl2mZBXgsgJaeaT6DVWDUeoH2wbM0z0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=twvo2S5XjbqEkOWkAQpnGbrW91qUdbVnGPc73sw06G4=; b=FPSjUuYVkBT5ICGTyRdFRR8n78
 c/DVfR1T8r9g30mqClLHTjbPdcjmBJ8UEEpMTSp0PinOMIEhSorA4C9mHN3hAaptkX+PjbDxLQOr4
 K4dhnmTb/RVH0/eouVN0rlcPZ1F1NAqb4dxgnUDlmEM0D2Ge+3od5KcTGojAklDvvBW4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLFp3-000000008Sd-0AX9
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 08:12:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ACC7C417D5;
 Mon, 26 Oct 2026 08:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8936D1F01825;
 Mon, 26 Oct 2026 08:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793002363;
 bh=twvo2S5XjbqEkOWkAQpnGbrW91qUdbVnGPc73sw06G4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NFNJNicX6mXjCGpZhiZiDheE4OhQLW4CMPrvMwmhEQV6Sq1TxOHedI51pkk8pDhNS
 PD8CDdmWZcRxvMEAmdne/GyfcWHutE84sT6cGLcWhob6VmPa5DFpancxtpgIemAgaS
 Syt6R0JdrMc6iqm2autEf7mFIGcPTNXDKMxLPI46onGdFDgqyEisFCvH98js/oc5pU
 jM8ULVd2dxYAzoC1xbI9lwPXYMmb7C/wYJ76l99gv+eqVsclhAXbj6jhGt5Uw/LQHn
 Ef+4BnJX9phtyvdah+Yl5c8tgHidpPYY8nqarZoU5Tcpt3/1EROrnWsO+G0qqdn24z
 J/Upbu1Wh0rbg==
Date: Mon, 26 Oct 2026 09:12:38 +0100
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20261026-virologen-abtropfen-endlich-b6ffb9111409@brauner>
References: <20261023-work-dcache-casefold-v1-0-1b0bd5c73a69@kernel.org>
 <20261023-work-dcache-casefold-v1-1-1b0bd5c73a69@kernel.org>
 <20261024192017.GG2553@quark>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261024192017.GG2553@quark>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLFp3-000000008Sd-0AX9
Subject: Re: [f2fs-dev] [PATCH 1/2] dcache: don't leave negative dentries in
 casefolded directories
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Christian Brauner via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Gabriel Krisman Bertazi <krisman@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 24, 2026 at 12:20:17PM -0700, Eric Biggers wrote:
> On Fri, Oct 23, 2026 at 02:44:22PM +0200, Christian Brauner wrote:
> > +static __always_inline bool d_delete_drop(struct dentry *dentry)
> > +{
> > +	return dentry_negative_policy ||
> > +	       IS_CASEFOLDED(d_inode(dentry->d_parent));
> > +}
> 
> Should this also check IS_ENABLED(CONFIG_UNICODE), so there will be no
> overhead when CONFIG_UNICODE=n?

Sounds good. I'll fold then in when applying.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
