Return-Path: <SRS0=bY38=3N=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF5AC2D0CE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jan 2020 05:38:12 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149EC2070A;
	Fri, 24 Jan 2020 05:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="QcWbUKrm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="jsS50TiY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="TWDF3zSJ";
	dkim=neutral (0-bit key) header.d=aol.com header.i=@aol.com header.b="XLwynAJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149EC2070A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Y8o9KkhbQgk6ZjleU7UbZDA5GJeurFYT1XjHuvR3x20=; b=QcWbUKrmjmnDiqJIgLbgRnsTl
	hQ9cOoQRbynohYJzDQ+0n56JCPM+0XsFuDJrlNQMqDgO/d7fGi872EN2yOk+XmT+/NZ0dGIookZOg
	ywqsvSBzj/Wr0L4sw+CfmB6NRXK6xuGfXpbJ72Hl81d1sLFhsCFjhnRClNrjjqLSgM2xc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iurfX-00013m-MG; Fri, 24 Jan 2020 05:38:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <hsiangkao@aol.com>) id 1iurfW-00013b-MN
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Jan 2020 05:38:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9necSZIJYyRRJ8jaU0pxv6QHcZkJLNsfLRyto+nrVh0=; b=jsS50TiYjhy9XQEHMhnU8Fb3dZ
 +qjvqaHYDIlIcZzpnJiw0g5f5jWg0qkYouPvGky9SXJA4MvPWsqutEkWWn+fTgRg7oXbfKpUsydEE
 /xH2UfcVXLwTwrBppaEiNqtQ/717Ufcs29TP0TuNYVwyhjjHMknFZaoSZHiQ17dFcRdM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9necSZIJYyRRJ8jaU0pxv6QHcZkJLNsfLRyto+nrVh0=; b=TWDF3zSJl/aqJf8KZ8BPgmnEji
 gthM1e51ocm23LJZCB2002Q28G3+4d3ufNVOADScIMYU9xVHA7YOEigDnHdbqgclTNl9lvkLWZs7Y
 Wz3sqNm9WusoKg5uhEinJSwzyRYFEXfz4Pd0ssiu9yjArmxmECeJiXN34+h7VWwZCCmw=;
Received: from sonic314-21.consmr.mail.gq1.yahoo.com ([98.137.69.84])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1iurfU-00GYWL-3D
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Jan 2020 05:38:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1579844282; bh=9necSZIJYyRRJ8jaU0pxv6QHcZkJLNsfLRyto+nrVh0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=XLwynAJRScyQDLoCb9gCOYg7IMd0QxP1gndGXmiPXQytf58WBOa7obpV6tcPFc6tEFLrzn+y1QakSLUd55l/kZbJxSW1YAwv7l0S4vN504xqQaGxV7Z5a0j1tAg7vmpHJ3rHiuvQVjUTjXPdZ7JRHl82A7SBVRxYzrR+ozcA+rv4yH0YbkEXJaMTpzXYKFrTMwzC3zzplOx/bB/gUfmMg7J+cL6NFY8cAkNhtiSJY9ZSCS+A1/w86IVEyGp4oOUMykKO7tBEX9rB/muCZuGhKfnDhJs9m3xU360jU5utmC5oxZnJfAR44XoRbWHS19gI5bNgaZIt0xJhwD+qyPY40A==
X-YMail-OSG: qwkSMKYVM1nerF17bL_ncoKZ2f_7EvelyTnyy3.ARwKl_O4amY4btNkvurM6GkS
 tz_M1Jj66QgrapfINFE7UFlEbiLNWpxMMC0irIKqVtR4VgNCfNvkd2GitLYcrbCEmRe__rz9aEDG
 ZfHMAOJOxx8fZ6DX9H0vybNj_il3xFVv7olWcc976yMVozTOQdrl9J8EmFPPy4uUXGR8aJNwQjbP
 U0jJFJDZItheE38vAa3kAOdwUJzSRNztxYZIVgkvclBGwRBEHp_2tN7swPgkkgpcM1RHu7Ar0nM1
 zCyuJZxodiGH0E6xnDscrLD5EybnjK5gxz_mv8_Dc_gtUlE6.IhtxeaDuoD.lVe_7enHdDvyZpVA
 Fm6oZEn7vQTuCO8pj9Zd1rM7wU5BVpa7v0iDmjHZxOVvrnhXwrMWqkyZJurCYT5IZG_Pwg.u8tkx
 1SIUkcsDBLAI0u8Jj03SLeMwfB.cfPkxTUKOS8rrzMl.iVDp2HFup9VnvedaUEqwUaGqyIImdzm3
 9YQvtEyumMbr7Hg.gHWnwE67kU7wpQm9nbxIE_l.CjFarf4wu12imoWhbtFQpj2ltbeLIK7qu3Fd
 6yOudhzS1S3pavDFunOHu9UXRtoXrKEglCQhA3YR1NAVrHmOr8CzPHPMxd3DWdzy7S3gRnDpG_AX
 gk2c3R.D54fyXcrsNuWRsGpAL1aa1VGy77HIT1mAfFY0MSeqv1B5eTq7EJFWUSIMTD7tOgh4vBDK
 BNZ1oD5enzzGfKh_1JjuDf69PFMWYbH.QfVWY61YOWdBzSS0uaLHBOXbwzW5rV1XkQKi4j1zmX.l
 10Fk3AeDnoQaWx5Moqv18Oz1Tc..AEiBaD9aTGQfVX7YUyi7jHRovnVy8mAD2F4bQKE5.3nAx427
 uF3LPxI_gkd8LkauPvDyh7HD7SmoZtTubyPxMtgueBIA4YNqGDL8J6IFOMdlNO7jE1WcKDTLE63W
 Uy16LO2Vogu2th1yjnnGpaAhHbjMySKUq3u0u4.HNtd5cg0OuHjjFe0E5YgVM3tI825GTG5bsVOm
 A2H1FYmGq3JdexnGbqGnTfdPOZi4h6DPLHT3Fvxg46yJvXW193JJf69qKG2KdnjnVPYe3396Y13D
 FW6pqj9hNUKu6w_oGAPTBVbEYT2yNXr4.wg1PnYpFHUPDKarAClWCOAmxzlwTCOLK0GuNiWK9ItM
 nNzEWorDfEZi_7RGLuUbFWKb2DKSEaYMBJhg4wqyaK8Ii1GeCkOqWePBwMZieIyKILpHQX3GegwY
 5fPch8JKIXEepoGK7Ud4WkupjyMgzkE8Pe3XRIuVL3slJZMH8RR9urgW831I17RP2Xyx0gBSALJS
 bfVsd3XrV2xpw4O5RqUj16Y76vzS3DemXYXClYZ5yRxjlpIHmk7ctla4tZwODvVmAy.dJKizhsV1
 SdNFR_yBYcwpZQ3UEzU3kojQlAqDMgkk1Ag--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.gq1.yahoo.com with HTTP; Fri, 24 Jan 2020 05:38:02 +0000
Received: by smtp428.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID f9b7953f40d5a7531fce28ad55186da6; 
 Fri, 24 Jan 2020 05:27:55 +0000 (UTC)
Date: Fri, 24 Jan 2020 13:27:50 +0800
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20200124052740.GB31271@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200124041234.159740-1-ebiggers@kernel.org>
 <20200124050423.GA31271@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200124051601.GB832@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200124051601.GB832@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_181)
X-Headers-End: 1iurfU-00GYWL-3D
Subject: Re: [f2fs-dev] [PATCH] ext4: fix race conditions in ->d_compare()
 and ->d_hash()
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
From: Gao Xiang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: Daniel Rosenberg <drosen@google.com>,
 linux-f2fs-devel@lists.sourceforge.net,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jan 23, 2020 at 09:16:01PM -0800, Eric Biggers wrote:
> On Fri, Jan 24, 2020 at 01:04:25PM +0800, Gao Xiang wrote:
> > > diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> > > index 8964778aabefb..0129d14629881 100644
> > > --- a/fs/ext4/dir.c
> > > +++ b/fs/ext4/dir.c
> > > @@ -671,9 +671,11 @@ static int ext4_d_compare(const struct dentry *dentry, unsigned int len,
> > >  			  const char *str, const struct qstr *name)
> > >  {
> > >  	struct qstr qstr = {.name = str, .len = len };
> > > -	struct inode *inode = dentry->d_parent->d_inode;
> > > +	const struct dentry *parent = READ_ONCE(dentry->d_parent);
> > 
> > I'm not sure if we really need READ_ONCE d_parent here (p.s. d_parent
> > won't be NULL anyway), and d_seq will guard all its validity. If I'm
> > wrong, correct me kindly...
> > 
> > Otherwise, it looks good to me...
> > Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
> > 
> 
> While d_parent can't be set to NULL, it can still be changed concurrently.
> So we need READ_ONCE() to ensure that a consistent value is used.

If I understand correctly, unlazy RCU->ref-walk will be guarded by
seqlock, and for ref-walk we have d_lock (and even parent lock)
in relative paths. So I prematurely think no race of renaming or
unlinking evenually.

I'm curious about that if experts could correct me about this.

Thanks,
Gao Xiang

> 
> - Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
