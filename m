From: Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [PATCH 1/2] f2fs: detect host-managed SMR by feature
	flag
Date: Wed, 24 Aug 2016 15:31:39 -0500
Message-ID: <CAJVOszCrULuMVwhcoaSnP=noa4SajON2UDyz3pVdG=jSPn0P_A@mail.gmail.com>
References: <20160614184322.88117-1-jaegeuk@kernel.org>
	<BY2PR04MB19767501012B2D01073F1AA09F550@BY2PR04MB1976.namprd04.prod.outlook.com>
	<20160615163246.GA93951@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shaun.tancheff@seagate.com>) id 1bceqr-0003cg-Lw
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 24 Aug 2016 20:32:47 +0000
Received: from mx0b-00003501.pphosted.com ([67.231.152.68]
	helo=mx0a-000cda01.pphosted.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bceqX-0001pk-Tm
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 24 Aug 2016 20:32:45 +0000
Received: from pps.filterd (m0075032.ppops.net [127.0.0.1])
	by mx0b-00003501.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	u7OKUQQl016971 for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 24 Aug 2016 16:32:01 -0400
Received: from mail-qt0-f199.google.com (mail-qt0-f199.google.com
	[209.85.216.199])
	by mx0b-00003501.pphosted.com with ESMTP id 251fmwj7rj-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT) for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 24 Aug 2016 16:32:00 -0400
Received: by mail-qt0-f199.google.com with SMTP id 101so53344429qtb.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 24 Aug 2016 13:32:00 -0700 (PDT)
In-Reply-To: <20160615163246.GA93951@jaegeuk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Josh Bingaman <josh.bingaman@seagate.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, Damien Le Moal <Damien.LeMoal@hgst.com>, schmorp@schmorp.de, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>

Hi Jaegeuk,

On Wed, Jun 15, 2016 at 11:32 AM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> On Wed, Jun 15, 2016 at 04:21:13AM +0000, Damien Le Moal wrote:
>> On 6/15/16 03:45, Jaegeuk Kim wrote:
>> > If mkfs.f2fs gives a feature flag for host-managed SMR, we can set mode=lfs
>> > by default.
>> >
>> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> > ---
>> >  fs/f2fs/f2fs.h  | 21 +++++++++++++++++++++
>> >  fs/f2fs/super.c | 14 ++++++++------
>> >  2 files changed, 29 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> > index 32be19e..1a19c02 100644
>> > --- a/fs/f2fs/f2fs.h
>> > +++ b/fs/f2fs/f2fs.h
>> > @@ -133,6 +133,7 @@ struct f2fs_mount_info {
>> >  };
>> >
>> >  #define F2FS_FEATURE_ENCRYPT       0x0001
>> > +#define F2FS_FEATURE_HMSMR 0x0002
>> >
>> >  #define F2FS_HAS_FEATURE(sb, mask)                                 \
>> >     ((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
>> > @@ -2354,6 +2355,26 @@ static inline int f2fs_sb_has_crypto(struct super_block *sb)
>> >     return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_ENCRYPT);
>> >  }
>> >
>> > +static inline int f2fs_sb_mounted_hmsmr(struct super_block *sb)
>> > +{
>> > +   return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_HMSMR);
>> > +}
>> > +
>> > +static inline void set_opt_mode(struct f2fs_sb_info *sbi, unsigned int mt)
>> > +{
>> > +   clear_opt(sbi, ADAPTIVE);
>> > +   clear_opt(sbi, LFS);
>> > +
>> > +   switch (mt) {
>> > +   case F2FS_MOUNT_ADAPTIVE:
>> > +           set_opt(sbi, ADAPTIVE);
>> > +           break;
>> > +   case F2FS_MOUNT_LFS:
>> > +           set_opt(sbi, LFS);
>> > +           break;
>> > +   }
>> > +}
>> > +
>> >  static inline bool f2fs_may_encrypt(struct inode *inode)
>> >  {
>> >  #ifdef CONFIG_F2FS_FS_ENCRYPTION
>> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> > index edc736d..71b6066 100644
>> > --- a/fs/f2fs/super.c
>> > +++ b/fs/f2fs/super.c
>> > @@ -515,12 +515,10 @@ static int parse_options(struct super_block *sb, char *options)
>> >                             return -ENOMEM;
>> >                     if (strlen(name) == 8 &&
>> >                                     !strncmp(name, "adaptive", 8)) {
>> > -                           set_opt(sbi, ADAPTIVE);
>> > -                           clear_opt(sbi, LFS);
>> > +                           set_opt_mode(sbi, F2FS_MOUNT_ADAPTIVE);
>> >                     } else if (strlen(name) == 3 &&
>> >                                     !strncmp(name, "lfs", 3)) {
>> > -                           clear_opt(sbi, ADAPTIVE);
>> > -                           set_opt(sbi, LFS);
>> > +                           set_opt_mode(sbi, F2FS_MOUNT_LFS);
>> >                     } else {
>> >                             kfree(name);
>> >                             return -EINVAL;
>> > @@ -980,7 +978,10 @@ static void default_options(struct f2fs_sb_info *sbi)
>> >     set_opt(sbi, EXTENT_CACHE);
>> >     sbi->sb->s_flags |= MS_LAZYTIME;
>> >     set_opt(sbi, FLUSH_MERGE);
>> > -   set_opt(sbi, ADAPTIVE);
>> > +   if (f2fs_sb_mounted_hmsmr(sbi->sb))
>> > +           set_opt_mode(sbi, F2FS_MOUNT_LFS);
>> > +   else
>> > +           set_opt_mode(sbi, F2FS_MOUNT_ADAPTIVE);
>>
>> Strictly speaking, host-aware drives would not require the LFS mode
>> as any zone of the disk can be randomly written and so the occasional
>> in-place updates of the adaptive mode would be OK. However, randomly
>> writing host-aware drives can lead to a lot of background activity on
>> the drive side for internal management of the accumulated random writes,
>> with a potential performance drop over time (this is highly dependent on
>> the drive FW implementation though).
>>
>> So I think it would be good to also enable the LFS mode by default for
>> host-aware devices, unless the user has explicitly specified mount with
>> adaptive mode (if the user "knows" that the drive FW handles very
>> efficiently random writes).
>
> Agreed. Would HASMR also provide the same geometry, zone information, in mkfs?
> Cause I haven't tested it so far.

Yes. Host Aware SMR reports geometry in the same way. As far as I can tell,
your current mkfs for f2fs works correctly for HASMR.

> IIRC, we discussed about HASMR with Marc Lehmann last year, and he gave the
> below link which sums up.
>
> https://urldefense.proofpoint.com/v2/url?u=http-3A__comments.gmane.org_gmane.linux.file-2Dsystems.f2fs_2854&d=CwIBAg&c=IGDlg0lD0b-nebmJJ0Kp8A&r=Wg5NqlNlVTT7Ugl8V50qIHLe856QW0qfG3WVYGOrWzA&m=3Uw29rZTMJsKnUE9bBduFOdp3OiEwJhpgbJ9GmyO_SU&s=YNxrXKMJpd-BPHnYG8ctqg6ct58p2yqO3BRKlbjBO_s&e=
> https://urldefense.proofpoint.com/v2/url?u=http-3A__blog.schmorp.de_2015-2D10-2D08-2Dsmr-2Darchive-2Ddrives-2Dfast-2Dnow.html&d=CwIBAg&c=IGDlg0lD0b-nebmJJ0Kp8A&r=Wg5NqlNlVTT7Ugl8V50qIHLe856QW0qfG3WVYGOrWzA&m=3Uw29rZTMJsKnUE9bBduFOdp3OiEwJhpgbJ9GmyO_SU&s=SC_RkdkfDQZTeIccq0o1zE4siI_RgDL4UhiVc1VzENY&e=

I think above applies to 'drive managed' SMR where the upper level
has no insight into the underlying zone layout.

>> So how about also introducing a F2FS_FEATURE_HASMR feature flag to
>> handle these different cases ?
>
> Yes, so once I can retrieve the zone information from the device, surely I'll
> add that.

I have posted some patches that will allow you to retrieve the zone
information for both HA and HM drives.

Can you see if this would meet your needs?

The data is returned to the BIO is in the same (drive) format as SG_IO.

>> Also, I think that the DISCARD option must be enabled by default for
>> HMSMR disks. Otherwise, zones write pointer will never get reset.
>> The same applies to HASMR devices mounted with the LFS mode.
>> (In any case, the discard handling does not look like it will always
>> align to the device zone size, which will fail on a zoned disk (discard
>> granularity is the zone size). I may be missing something though. Still
>> checking.)
>
> Yup, will do. BTW, I remember I fixed zone-aligned discard issue before.
> Could you please check the latest dev-test branch in f2fs.git?
> I'm used to rebase that branch occasionally when I changed the previous patches.

I think you will need to have the have access to the zone information.

Regards,
Shaun Tancheff

------------------------------------------------------------------------------
