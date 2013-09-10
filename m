From: Russ Knize <Russ.Knize@motorola.com>
Subject: Re: [PATCH] f2fs: fix handling orphan inodes
Date: Tue, 10 Sep 2013 10:42:18 -0500
Message-ID: <CAGfvh60utYQ-uN=RPu-oO+zr1+Er8GABdOvWViZPz0X6SHwUqA@mail.gmail.com>
References: <1375343917-24093-1-git-send-email-jaegeuk.kim@samsung.com>
	<51FA2E1A.1080604@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0849788426947639035=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rknize2@motorola.com>) id 1VJQ5Z-0006x9-Dq
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 10 Sep 2013 15:42:49 +0000
Received: from exprod5og112.obsmtp.com ([64.18.0.24])
	by sog-mx-3.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VJQ5X-0008Kn-Fi
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 10 Sep 2013 15:42:49 +0000
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id
	r8AFdjE1026645 for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 10 Sep 2013 11:39:45 -0400 (EDT)
Received: from mail-we0-f171.google.com (mail-we0-f171.google.com
	[74.125.82.171])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id
	r8AFdieW026621
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 10 Sep 2013 11:39:45 -0400 (EDT)
Received: by mail-we0-f171.google.com with SMTP id t61so5693296wes.16
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 10 Sep 2013 08:42:38 -0700 (PDT)
In-Reply-To: <51FA2E1A.1080604@cn.fujitsu.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

--===============0849788426947639035==
Content-Type: multipart/alternative; boundary=089e0122f49cc1411804e6095aee

--089e0122f49cc1411804e6095aee
Content-Type: text/plain; charset=ISO-8859-1

Hi Jaegeuk,

This patch seems to have introduced a bug in the handling of sbi->n_orphans
during recovery.  Recovery can cause orphans to be added to the list
without incrementing n_orphans via:

- recover_fsync_data
 - find_fsync_dnodes
  - recover_inode
   - recover_dentry
    - f2fs_delete_entry
     - add_orphan_inode

Later, these orphans are removed via:

- recover_fsync_data
 - recover_data
  - do_recover_data
   - check_index_in_prev_nodes
    - truncate_hole
     - evict
      - f2fs_evict_inode
       - remove_inode_page
        - truncate_node
         - remove_orphan_inode

remove_orphan_inode() will decrement sbi->n_orphans, which was initialized
to zero by init_orphan_info().  Since it is unsigned, it rolls over and
from then on the check in acquire_orphan_inode() returns ENOSPC.

The obvious fix seems to be to call acquire_orphan_inode()
from recover_dentry(), but I thought I'd run it past you first.

Russ



On Thu, Aug 1, 2013 at 4:44 AM, Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:

> On 08/01/2013 03:58 PM, Jaegeuk Kim wrote:
>
> > This patch fixes mishandling of the sbi->n_orphans variable.
> >
> > If users request lots of f2fs_unlink(), check_orphan_space() could be
> contended.
> > In such the case, sbi->n_orphans can be read incorrectly so that
> f2fs_unlink()
> > would fall into the wrong state which results in the failure of
> > add_orphan_inode().
> >
> > So, let's increment sbi->n_orphans virtually prior to the actual orphan
> inode
> > stuffs. After that, let's release sbi->n_orphans by calling
> release_orphan_inode
> > or remove_orphan_inode.
>
> Hi Kim,
> The key point is that we did not reduce sbi->n_orphans when we
> release/remove orphan inode,
> so just adding the reduction step can fix this issue.
> But why moving the increment of sbi->n_orphans before we add orphan inode?
> It seems that we
> can not get benefit from it, and it makes the procedure a bit complex,
> because we should
> reduce the sbi->n_orphans in some fail pathes before we really add orphan
> inode.
>
> Thanks,
> Gu
>
> >
> > Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> > ---
> >  fs/f2fs/checkpoint.c | 13 ++++++++++---
> >  fs/f2fs/dir.c        |  2 ++
> >  fs/f2fs/f2fs.h       |  3 ++-
> >  fs/f2fs/namei.c      | 19 ++++++++++++++-----
> >  4 files changed, 28 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index fe91773..c5a5c39 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -182,7 +182,7 @@ const struct address_space_operations f2fs_meta_aops
> = {
> >       .set_page_dirty = f2fs_set_meta_page_dirty,
> >  };
> >
> > -int check_orphan_space(struct f2fs_sb_info *sbi)
> > +int acquire_orphan_inode(struct f2fs_sb_info *sbi)
> >  {
> >       unsigned int max_orphans;
> >       int err = 0;
> > @@ -197,10 +197,19 @@ int check_orphan_space(struct f2fs_sb_info *sbi)
> >       mutex_lock(&sbi->orphan_inode_mutex);
> >       if (sbi->n_orphans >= max_orphans)
> >               err = -ENOSPC;
> > +     else
> > +             sbi->n_orphans++;
> >       mutex_unlock(&sbi->orphan_inode_mutex);
> >       return err;
> >  }
> >
> > +void release_orphan_inode(struct f2fs_sb_info *sbi)
> > +{
> > +     mutex_lock(&sbi->orphan_inode_mutex);
> > +     sbi->n_orphans--;
> > +     mutex_unlock(&sbi->orphan_inode_mutex);
> > +}
> > +
> >  void add_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
> >  {
> >       struct list_head *head, *this;
> > @@ -229,8 +238,6 @@ retry:
> >               list_add(&new->list, this->prev);
> >       else
> >               list_add_tail(&new->list, head);
> > -
> > -     sbi->n_orphans++;
> >  out:
> >       mutex_unlock(&sbi->orphan_inode_mutex);
> >  }
> > diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> > index d1bb260..384c6da 100644
> > --- a/fs/f2fs/dir.c
> > +++ b/fs/f2fs/dir.c
> > @@ -572,6 +572,8 @@ void f2fs_delete_entry(struct f2fs_dir_entry
> *dentry, struct page *page,
> >
> >               if (inode->i_nlink == 0)
> >                       add_orphan_inode(sbi, inode->i_ino);
> > +             else
> > +                     release_orphan_inode(sbi);
> >       }
> >
> >       if (bit_pos == NR_DENTRY_IN_BLOCK) {
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index a6858c7..78777cd 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1044,7 +1044,8 @@ void destroy_segment_manager(struct f2fs_sb_info
> *);
> >  struct page *grab_meta_page(struct f2fs_sb_info *, pgoff_t);
> >  struct page *get_meta_page(struct f2fs_sb_info *, pgoff_t);
> >  long sync_meta_pages(struct f2fs_sb_info *, enum page_type, long);
> > -int check_orphan_space(struct f2fs_sb_info *);
> > +int acquire_orphan_inode(struct f2fs_sb_info *);
> > +void release_orphan_inode(struct f2fs_sb_info *);
> >  void add_orphan_inode(struct f2fs_sb_info *, nid_t);
> >  void remove_orphan_inode(struct f2fs_sb_info *, nid_t);
> >  int recover_orphan_inodes(struct f2fs_sb_info *);
> > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > index 3297278..4e47518 100644
> > --- a/fs/f2fs/namei.c
> > +++ b/fs/f2fs/namei.c
> > @@ -239,7 +239,7 @@ static int f2fs_unlink(struct inode *dir, struct
> dentry *dentry)
> >       if (!de)
> >               goto fail;
> >
> > -     err = check_orphan_space(sbi);
> > +     err = acquire_orphan_inode(sbi);
> >       if (err) {
> >               kunmap(page);
> >               f2fs_put_page(page, 0);
> > @@ -393,7 +393,7 @@ static int f2fs_rename(struct inode *old_dir, struct
> dentry *old_dentry,
> >       struct inode *old_inode = old_dentry->d_inode;
> >       struct inode *new_inode = new_dentry->d_inode;
> >       struct page *old_dir_page;
> > -     struct page *old_page;
> > +     struct page *old_page, *new_page;
> >       struct f2fs_dir_entry *old_dir_entry = NULL;
> >       struct f2fs_dir_entry *old_entry;
> >       struct f2fs_dir_entry *new_entry;
> > @@ -415,7 +415,6 @@ static int f2fs_rename(struct inode *old_dir, struct
> dentry *old_dentry,
> >       ilock = mutex_lock_op(sbi);
> >
> >       if (new_inode) {
> > -             struct page *new_page;
> >
> >               err = -ENOTEMPTY;
> >               if (old_dir_entry && !f2fs_empty_dir(new_inode))
> > @@ -427,9 +426,13 @@ static int f2fs_rename(struct inode *old_dir,
> struct dentry *old_dentry,
> >               if (!new_entry)
> >                       goto out_dir;
> >
> > +             err = acquire_orphan_inode(sbi);
> > +             if (err)
> > +                     goto put_out_dir;
> > +
> >               if (update_dent_inode(old_inode, &new_dentry->d_name)) {
> > -                     f2fs_put_page(new_page, 1);
> > -                     goto out_dir;
> > +                     release_orphan_inode(sbi);
> > +                     goto put_out_dir;
> >               }
> >
> >               f2fs_set_link(new_dir, new_entry, new_page, old_inode);
> > @@ -438,8 +441,12 @@ static int f2fs_rename(struct inode *old_dir,
> struct dentry *old_dentry,
> >               if (old_dir_entry)
> >                       drop_nlink(new_inode);
> >               drop_nlink(new_inode);
> > +
> >               if (!new_inode->i_nlink)
> >                       add_orphan_inode(sbi, new_inode->i_ino);
> > +             else
> > +                     release_orphan_inode(sbi);
> > +
> >               update_inode_page(new_inode);
> >       } else {
> >               err = f2fs_add_link(new_dentry, old_inode);
> > @@ -472,6 +479,8 @@ static int f2fs_rename(struct inode *old_dir, struct
> dentry *old_dentry,
> >       mutex_unlock_op(sbi, ilock);
> >       return 0;
> >
> > +put_out_dir:
> > +     f2fs_put_page(new_page, 1);
> >  out_dir:
> >       if (old_dir_entry) {
> >               kunmap(old_dir_page);
>
>
>
>
> ------------------------------------------------------------------------------
> Get your SQL database under version control now!
> Version control is standard for application code, but databases havent
> caught up. So what steps can you take to put your SQL databases under
> version control? Why should you start doing it? Read more to find out.
> http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>

--089e0122f49cc1411804e6095aee
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jaegeuk,<div><br></div><div>This patch seems to have in=
troduced a bug in the handling of=A0sbi-&gt;n_orphans during recovery. =A0R=
ecovery can cause orphans to be added to the list without incrementing n_or=
phans via:</div>

<div><br></div><div>- recover_fsync_data<br></div><div>=A0- find_fsync_dnod=
es<br></div><div>=A0 - recover_inode<br></div><div>=A0 =A0- recover_dentry<=
br></div><div>=A0 =A0 - f2fs_delete_entry<br></div><div>=A0 =A0 =A0- add_or=
phan_inode<br>

</div><div><br></div><div>Later, these orphans are removed via:</div><div><=
br></div><div>-=A0recover_fsync_data</div><div>=A0- recover_data<br></div><=
div>=A0 - do_recover_data</div><div>=A0 =A0-=A0check_index_in_prev_nodes</d=
iv><div>

=A0 =A0 -=A0truncate_hole</div><div>=A0 =A0 =A0-=A0evict</div><div>=A0 =A0 =
=A0 -=A0f2fs_evict_inode</div><div>=A0 =A0 =A0 =A0-=A0remove_inode_page</di=
v><div>=A0 =A0 =A0 =A0 -=A0truncate_node</div><div>=A0 =A0 =A0 =A0 =A0-=A0r=
emove_orphan_inode</div><div><br></div><div>remove_orphan_inode() will decr=
ement=A0sbi-&gt;n_orphans, which was initialized to zero by=A0init_orphan_i=
nfo(). =A0Since it is unsigned, it rolls over and from then on the check in=
 acquire_orphan_inode() returns ENOSPC.<br>

</div><div><br></div><div>The obvious fix seems to be to call=A0acquire_orp=
han_inode() from=A0recover_dentry(), but I thought I&#39;d run it past you =
first.</div><div><br></div><div>Russ</div><div><br></div></div><div class=
=3D"gmail_extra">

<br><br><div class=3D"gmail_quote">On Thu, Aug 1, 2013 at 4:44 AM, Gu Zheng=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:guz.fnst@cn.fujitsu.com" target=3D=
"_blank">guz.fnst@cn.fujitsu.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">

<div class=3D"im">On 08/01/2013 03:58 PM, Jaegeuk Kim wrote:<br>
<br>
&gt; This patch fixes mishandling of the sbi-&gt;n_orphans variable.<br>
&gt;<br>
&gt; If users request lots of f2fs_unlink(), check_orphan_space() could be =
contended.<br>
&gt; In such the case, sbi-&gt;n_orphans can be read incorrectly so that f2=
fs_unlink()<br>
&gt; would fall into the wrong state which results in the failure of<br>
&gt; add_orphan_inode().<br>
&gt;<br>
&gt; So, let&#39;s increment sbi-&gt;n_orphans virtually prior to the actua=
l orphan inode<br>
&gt; stuffs. After that, let&#39;s release sbi-&gt;n_orphans by calling rel=
ease_orphan_inode<br>
&gt; or remove_orphan_inode.<br>
<br>
</div>Hi Kim,<br>
The key point is that we did not reduce sbi-&gt;n_orphans when we release/r=
emove orphan inode,<br>
so just adding the reduction step can fix this issue.<br>
But why moving the increment of sbi-&gt;n_orphans before we add orphan inod=
e? It seems that we<br>
can not get benefit from it, and it makes the procedure a bit complex, beca=
use we should<br>
reduce the sbi-&gt;n_orphans in some fail pathes before we really add orpha=
n inode.<br>
<br>
Thanks,<br>
Gu<br>
<div><div class=3D"h5"><br>
&gt;<br>
&gt; Signed-off-by: Jaegeuk Kim &lt;<a href=3D"mailto:jaegeuk.kim@samsung.c=
om">jaegeuk.kim@samsung.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0fs/f2fs/checkpoint.c | 13 ++++++++++---<br>
&gt; =A0fs/f2fs/dir.c =A0 =A0 =A0 =A0| =A02 ++<br>
&gt; =A0fs/f2fs/f2fs.h =A0 =A0 =A0 | =A03 ++-<br>
&gt; =A0fs/f2fs/namei.c =A0 =A0 =A0| 19 ++++++++++++++-----<br>
&gt; =A04 files changed, 28 insertions(+), 9 deletions(-)<br>
&gt;<br>
&gt; diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c<br>
&gt; index fe91773..c5a5c39 100644<br>
&gt; --- a/fs/f2fs/checkpoint.c<br>
&gt; +++ b/fs/f2fs/checkpoint.c<br>
&gt; @@ -182,7 +182,7 @@ const struct address_space_operations f2fs_meta_ao=
ps =3D {<br>
&gt; =A0 =A0 =A0 .set_page_dirty =3D f2fs_set_meta_page_dirty,<br>
&gt; =A0};<br>
&gt;<br>
&gt; -int check_orphan_space(struct f2fs_sb_info *sbi)<br>
&gt; +int acquire_orphan_inode(struct f2fs_sb_info *sbi)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 unsigned int max_orphans;<br>
&gt; =A0 =A0 =A0 int err =3D 0;<br>
&gt; @@ -197,10 +197,19 @@ int check_orphan_space(struct f2fs_sb_info *sbi)=
<br>
&gt; =A0 =A0 =A0 mutex_lock(&amp;sbi-&gt;orphan_inode_mutex);<br>
&gt; =A0 =A0 =A0 if (sbi-&gt;n_orphans &gt;=3D max_orphans)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOSPC;<br>
&gt; + =A0 =A0 else<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 sbi-&gt;n_orphans++;<br>
&gt; =A0 =A0 =A0 mutex_unlock(&amp;sbi-&gt;orphan_inode_mutex);<br>
&gt; =A0 =A0 =A0 return err;<br>
&gt; =A0}<br>
&gt;<br>
&gt; +void release_orphan_inode(struct f2fs_sb_info *sbi)<br>
&gt; +{<br>
&gt; + =A0 =A0 mutex_lock(&amp;sbi-&gt;orphan_inode_mutex);<br>
&gt; + =A0 =A0 sbi-&gt;n_orphans--;<br>
&gt; + =A0 =A0 mutex_unlock(&amp;sbi-&gt;orphan_inode_mutex);<br>
&gt; +}<br>
&gt; +<br>
&gt; =A0void add_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 struct list_head *head, *this;<br>
&gt; @@ -229,8 +238,6 @@ retry:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add(&amp;new-&gt;list, this-&gt;prev)=
;<br>
&gt; =A0 =A0 =A0 else<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&amp;new-&gt;list, head);<br=
>
&gt; -<br>
&gt; - =A0 =A0 sbi-&gt;n_orphans++;<br>
&gt; =A0out:<br>
&gt; =A0 =A0 =A0 mutex_unlock(&amp;sbi-&gt;orphan_inode_mutex);<br>
&gt; =A0}<br>
&gt; diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c<br>
&gt; index d1bb260..384c6da 100644<br>
&gt; --- a/fs/f2fs/dir.c<br>
&gt; +++ b/fs/f2fs/dir.c<br>
&gt; @@ -572,6 +572,8 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dent=
ry, struct page *page,<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (inode-&gt;i_nlink =3D=3D 0)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_orphan_inode(sbi, inod=
e-&gt;i_ino);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 else<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_orphan_inode(sbi);<b=
r>
&gt; =A0 =A0 =A0 }<br>
&gt;<br>
&gt; =A0 =A0 =A0 if (bit_pos =3D=3D NR_DENTRY_IN_BLOCK) {<br>
&gt; diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h<br>
&gt; index a6858c7..78777cd 100644<br>
&gt; --- a/fs/f2fs/f2fs.h<br>
&gt; +++ b/fs/f2fs/f2fs.h<br>
&gt; @@ -1044,7 +1044,8 @@ void destroy_segment_manager(struct f2fs_sb_info=
 *);<br>
&gt; =A0struct page *grab_meta_page(struct f2fs_sb_info *, pgoff_t);<br>
&gt; =A0struct page *get_meta_page(struct f2fs_sb_info *, pgoff_t);<br>
&gt; =A0long sync_meta_pages(struct f2fs_sb_info *, enum page_type, long);<=
br>
&gt; -int check_orphan_space(struct f2fs_sb_info *);<br>
&gt; +int acquire_orphan_inode(struct f2fs_sb_info *);<br>
&gt; +void release_orphan_inode(struct f2fs_sb_info *);<br>
&gt; =A0void add_orphan_inode(struct f2fs_sb_info *, nid_t);<br>
&gt; =A0void remove_orphan_inode(struct f2fs_sb_info *, nid_t);<br>
&gt; =A0int recover_orphan_inodes(struct f2fs_sb_info *);<br>
&gt; diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c<br>
&gt; index 3297278..4e47518 100644<br>
&gt; --- a/fs/f2fs/namei.c<br>
&gt; +++ b/fs/f2fs/namei.c<br>
&gt; @@ -239,7 +239,7 @@ static int f2fs_unlink(struct inode *dir, struct d=
entry *dentry)<br>
&gt; =A0 =A0 =A0 if (!de)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;<br>
&gt;<br>
&gt; - =A0 =A0 err =3D check_orphan_space(sbi);<br>
&gt; + =A0 =A0 err =3D acquire_orphan_inode(sbi);<br>
&gt; =A0 =A0 =A0 if (err) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 kunmap(page);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 f2fs_put_page(page, 0);<br>
&gt; @@ -393,7 +393,7 @@ static int f2fs_rename(struct inode *old_dir, stru=
ct dentry *old_dentry,<br>
&gt; =A0 =A0 =A0 struct inode *old_inode =3D old_dentry-&gt;d_inode;<br>
&gt; =A0 =A0 =A0 struct inode *new_inode =3D new_dentry-&gt;d_inode;<br>
&gt; =A0 =A0 =A0 struct page *old_dir_page;<br>
&gt; - =A0 =A0 struct page *old_page;<br>
&gt; + =A0 =A0 struct page *old_page, *new_page;<br>
&gt; =A0 =A0 =A0 struct f2fs_dir_entry *old_dir_entry =3D NULL;<br>
&gt; =A0 =A0 =A0 struct f2fs_dir_entry *old_entry;<br>
&gt; =A0 =A0 =A0 struct f2fs_dir_entry *new_entry;<br>
&gt; @@ -415,7 +415,6 @@ static int f2fs_rename(struct inode *old_dir, stru=
ct dentry *old_dentry,<br>
&gt; =A0 =A0 =A0 ilock =3D mutex_lock_op(sbi);<br>
&gt;<br>
&gt; =A0 =A0 =A0 if (new_inode) {<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 struct page *new_page;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOTEMPTY;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (old_dir_entry &amp;&amp; !f2fs_empty_d=
ir(new_inode))<br>
&gt; @@ -427,9 +426,13 @@ static int f2fs_rename(struct inode *old_dir, str=
uct dentry *old_dentry,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!new_entry)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_dir;<br>
&gt;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 err =3D acquire_orphan_inode(sbi);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (err)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto put_out_dir;<br>
&gt; +<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (update_dent_inode(old_inode, &amp;new_=
dentry-&gt;d_name)) {<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 f2fs_put_page(new_page, 1);<=
br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_dir;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_orphan_inode(sbi);<b=
r>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto put_out_dir;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 f2fs_set_link(new_dir, new_entry, new_page=
, old_inode);<br>
&gt; @@ -438,8 +441,12 @@ static int f2fs_rename(struct inode *old_dir, str=
uct dentry *old_dentry,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (old_dir_entry)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drop_nlink(new_inode);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 drop_nlink(new_inode);<br>
&gt; +<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!new_inode-&gt;i_nlink)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_orphan_inode(sbi, new_=
inode-&gt;i_ino);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 else<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_orphan_inode(sbi);<b=
r>
&gt; +<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 update_inode_page(new_inode);<br>
&gt; =A0 =A0 =A0 } else {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D f2fs_add_link(new_dentry, old_inod=
e);<br>
&gt; @@ -472,6 +479,8 @@ static int f2fs_rename(struct inode *old_dir, stru=
ct dentry *old_dentry,<br>
&gt; =A0 =A0 =A0 mutex_unlock_op(sbi, ilock);<br>
&gt; =A0 =A0 =A0 return 0;<br>
&gt;<br>
&gt; +put_out_dir:<br>
&gt; + =A0 =A0 f2fs_put_page(new_page, 1);<br>
&gt; =A0out_dir:<br>
&gt; =A0 =A0 =A0 if (old_dir_entry) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 kunmap(old_dir_page);<br>
<br>
<br>
<br>
</div></div>---------------------------------------------------------------=
---------------<br>
Get your SQL database under version control now!<br>
Version control is standard for application code, but databases havent<br>
caught up. So what steps can you take to put your SQL databases under<br>
version control? Why should you start doing it? Read more to find out.<br>
<a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D49501711&amp;iu=
=3D/4140/ostg.clktrk" target=3D"_blank">http://pubads.g.doubleclick.net/gam=
pad/clk?id=3D49501711&amp;iu=3D/4140/ostg.clktrk</a><br>
_______________________________________________<br>
Linux-f2fs-devel mailing list<br>
<a href=3D"mailto:Linux-f2fs-devel@lists.sourceforge.net">Linux-f2fs-devel@=
lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel" t=
arget=3D"_blank">https://lists.sourceforge.net/lists/listinfo/linux-f2fs-de=
vel</a><br>
</blockquote></div><br></div>

--089e0122f49cc1411804e6095aee--


--===============0849788426947639035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. Consolidate legacy IT systems to a single system of record for IT
2. Standardize and globalize service processes across IT
3. Implement zero-touch automation to replace manual, redundant tasks
http://pubads.g.doubleclick.net/gampad/clk?id=51271111&iu=/4140/ostg.clktrk
--===============0849788426947639035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============0849788426947639035==--
