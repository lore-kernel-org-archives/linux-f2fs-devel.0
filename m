From: tast ky <tastky@gmail.com>
Subject: Re: [Bug] Inaccessible, unerasable file
Date: Wed, 20 Nov 2013 20:52:38 +0100
Message-ID: <CAPs1ukzwUnr52KtXfR3d+mg35XGo45D8SGyMKx=9qVifGU-XNQ@mail.gmail.com>
References: <CAPs1ukwgeqL1SFUGUPaM-aE=88dXS4GeaDDALG5WFLcoMvqg_g@mail.gmail.com>
	<1382440189.992.62.camel@kjgkr>
	<CAPs1ukz2EykkWP_H-U5UT_nuef5dpMRyTjHy4JCHKNoPLWKdpw@mail.gmail.com>
	<1382522306.992.84.camel@kjgkr>
	<CAPs1ukxRQFZfJhLUvUsZcGdeWhHkT-CpvkQDVxCHYJr6Q9Hz0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tastky@gmail.com>) id 1VjDpO-0004u6-By
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 Nov 2013 19:52:46 +0000
Received: from mail-la0-f46.google.com ([209.85.215.46])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VjDpN-0005MC-7Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 Nov 2013 19:52:46 +0000
Received: by mail-la0-f46.google.com with SMTP id eh20so7764586lab.33
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 20 Nov 2013 11:52:38 -0800 (PST)
In-Reply-To: <CAPs1ukxRQFZfJhLUvUsZcGdeWhHkT-CpvkQDVxCHYJr6Q9Hz0A@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-f2fs-devel@lists.sourceforge.net

If there are no further questions, I will format the stick this weekend.

On Tue, Nov 19, 2013 at 4:34 PM, tast ky <tastky@gmail.com> wrote:
> Hello again,
>
> after buying a new USB stick and moving everything but the partition's
> broken file & folder to it, I am now able to send you an image after
> all.
>
> Although the 21 GB partition was supposed to only contain those two
> tiny entries, df still reported 1.8 GB as in use.
>
> I did "dd if=/dev/zero of=hugefile; sync; rm hugefile; sync" on it to
> boost the compression ratio, the file is at 406 MiB compressed.
>
> The image was taken with "dd if=/dev/sde2 bs=4096 conv=notrunc | xz
> -T8 -9 - > f2fs_bugged.xz". Please tell me if that was correct,
> especially since I intend to format the stick soon.
>
> As to the actual download link, I will send you that in a separate
> email as I am not fond of having potentially personal data open on the
> web.
>
> NB: fsck.f2f2 still fails with "[fsck_chk_node_blk: 198] ni.blk_addr <
> F2FS_RAW_SUPER(sbi)->block_count".

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
