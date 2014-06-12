From: JP Abgrall <jpa@google.com>
Subject: [PATCH] License tweak: LGPL v2.1 vs LGPL v2
Date: Wed, 11 Jun 2014 21:56:56 -0700
Message-ID: <1402549016-3522-1-git-send-email-jpa@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jpa@google.com>) id 1Wux4a-00071Y-44
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Jun 2014 04:57:12 +0000
Received: from mail-pa0-f74.google.com ([209.85.220.74])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Wux4Y-0003Lj-2Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Jun 2014 04:57:12 +0000
Received: by mail-pa0-f74.google.com with SMTP id lj1so94482pab.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 11 Jun 2014 21:57:04 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

The important part is

    b) Use a suitable shared library mechanism for linking with the
    Library.  A suitable mechanism is one that (1) uses at run time a
    copy of the library already present on the user's computer system,
    rather than copying library functions into the executable, and (2)
    will operate properly with a modified version of the library, if
    the user installs one, as long as the modified version is
    interface-compatible with the version that the work was made with.

Change-Id: Ic1a02ec5cfcb2bedda3d53f3061037e1e7437221
Signed-off-by: JP Abgrall <jpa@google.com>
---
 COPYING | 215 +++++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 118 insertions(+), 97 deletions(-)

diff --git a/COPYING b/COPYING
index 88dc016..52f956d 100644
--- a/COPYING
+++ b/COPYING
@@ -1,6 +1,6 @@
 The tools for F2FS are covered by GNU Public License version 2.
-Exceptionally, the following files are also covered by the GNU Library General
-Public License Version 2 as the dual licenses.
+Exceptionally, the following files are also covered by the GNU Lesser General
+Public License Version 2.1 as the dual licenses.
 - include/f2fs_fs.h
 - lib/libf2fs.c
 - lib/libf2fs_io.c
@@ -360,115 +360,128 @@ library.  If this is what you want to do, use the GNU Library General
 Public License instead of this License.
 
 ================================================================================
-		  GNU LIBRARY GENERAL PUBLIC LICENSE
-		       Version 2, June 1991
+                  GNU LESSER GENERAL PUBLIC LICENSE
+                       Version 2.1, February 1999
 
- Copyright (C) 1991 Free Software Foundation, Inc.
-    		    59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ Copyright (C) 1991, 1999 Free Software Foundation, Inc.
+ 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
-[This is the first released version of the library GPL.  It is
- numbered 2 because it goes with version 2 of the ordinary GPL.]
+[This is the first released version of the Lesser GPL.  It also counts
+ as the successor of the GNU Library Public License, version 2, hence
+ the version number 2.1.]
 
-			    Preamble
+                            Preamble
 
   The licenses for most software are designed to take away your
 freedom to share and change it.  By contrast, the GNU General Public
 Licenses are intended to guarantee your freedom to share and change
 free software--to make sure the software is free for all its users.
 
-  This license, the Library General Public License, applies to some
-specially designated Free Software Foundation software, and to any
-other libraries whose authors decide to use it.  You can use it for
-your libraries, too.
-
-  When we speak of free software, we are referring to freedom, not
-price.  Our General Public Licenses are designed to make sure that you
-have the freedom to distribute copies of free software (and charge for
-this service if you wish), that you receive source code or can get it
-if you want it, that you can change the software or use pieces of it
-in new free programs; and that you know you can do these things.
+  This license, the Lesser General Public License, applies to some
+specially designated software packages--typically libraries--of the
+Free Software Foundation and other authors who decide to use it.  You
+can use it too, but we suggest you first think carefully about whether
+this license or the ordinary General Public License is the better
+strategy to use in any particular case, based on the explanations below.
+
+  When we speak of free software, we are referring to freedom of use,
+not price.  Our General Public Licenses are designed to make sure that
+you have the freedom to distribute copies of free software (and charge
+for this service if you wish); that you receive source code or can get
+it if you want it; that you can change the software and use pieces of
+it in new free programs; and that you are informed that you can do
+these things.
 
   To protect your rights, we need to make restrictions that forbid
-anyone to deny you these rights or to ask you to surrender the rights.
-These restrictions translate to certain responsibilities for you if
-you distribute copies of the library, or if you modify it.
+distributors to deny you these rights or to ask you to surrender these
+rights.  These restrictions translate to certain responsibilities for
+you if you distribute copies of the library or if you modify it.
 
   For example, if you distribute copies of the library, whether gratis
 or for a fee, you must give the recipients all the rights that we gave
 you.  You must make sure that they, too, receive or can get the source
-code.  If you link a program with the library, you must provide
-complete object files to the recipients so that they can relink them
-with the library, after making changes to the library and recompiling
+code.  If you link other code with the library, you must provide
+complete object files to the recipients, so that they can relink them
+with the library after making changes to the library and recompiling
 it.  And you must show them these terms so they know their rights.
 
-  Our method of protecting your rights has two steps: (1) copyright
-the library, and (2) offer you this license which gives you legal
+  We protect your rights with a two-step method: (1) we copyright the
+library, and (2) we offer you this license, which gives you legal
 permission to copy, distribute and/or modify the library.
 
-  Also, for each distributor's protection, we want to make certain
-that everyone understands that there is no warranty for this free
-library.  If the library is modified by someone else and passed on, we
-want its recipients to know that what they have is not the original
-version, so that any problems introduced by others will not reflect on
-the original authors' reputations.
+  To protect each distributor, we want to make it very clear that
+there is no warranty for the free library.  Also, if the library is
+modified by someone else and passed on, the recipients should know
+that what they have is not the original version, so that the original
+author's reputation will not be affected by problems that might be
+introduced by others.
 

-  Finally, any free program is threatened constantly by software
-patents.  We wish to avoid the danger that companies distributing free
-software will individually obtain patent licenses, thus in effect
-transforming the program into proprietary software.  To prevent this,
-we have made it clear that any patent must be licensed for everyone's
-free use or not licensed at all.
-
-  Most GNU software, including some libraries, is covered by the ordinary
-GNU General Public License, which was designed for utility programs.  This
-license, the GNU Library General Public License, applies to certain
-designated libraries.  This license is quite different from the ordinary
-one; be sure to read it in full, and don't assume that anything in it is
-the same as in the ordinary license.
-
-  The reason we have a separate public license for some libraries is that
-they blur the distinction we usually make between modifying or adding to a
-program and simply using it.  Linking a program with a library, without
-changing the library, is in some sense simply using the library, and is
-analogous to running a utility program or application program.  However, in
-a textual and legal sense, the linked executable is a combined work, a
-derivative of the original library, and the ordinary General Public License
-treats it as such.
-
-  Because of this blurred distinction, using the ordinary General
-Public License for libraries did not effectively promote software
-sharing, because most developers did not use the libraries.  We
-concluded that weaker conditions might promote sharing better.
-
-  However, unrestricted linking of non-free programs would deprive the
-users of those programs of all benefit from the free status of the
-libraries themselves.  This Library General Public License is intended to
-permit developers of non-free programs to use free libraries, while
-preserving your freedom as a user of such programs to change the free
-libraries that are incorporated in them.  (We have not seen how to achieve
-this as regards changes in header files, but we have achieved it as regards
-changes in the actual functions of the Library.)  The hope is that this
-will lead to faster development of free libraries.
+  Finally, software patents pose a constant threat to the existence of
+any free program.  We wish to make sure that a company cannot
+effectively restrict the users of a free program by obtaining a
+restrictive license from a patent holder.  Therefore, we insist that
+any patent license obtained for a version of the library must be
+consistent with the full freedom of use specified in this license.
+
+  Most GNU software, including some libraries, is covered by the
+ordinary GNU General Public License.  This license, the GNU Lesser
+General Public License, applies to certain designated libraries, and
+is quite different from the ordinary General Public License.  We use
+this license for certain libraries in order to permit linking those
+libraries into non-free programs.
+
+  When a program is linked with a library, whether statically or using
+a shared library, the combination of the two is legally speaking a
+combined work, a derivative of the original library.  The ordinary
+General Public License therefore permits such linking only if the
+entire combination fits its criteria of freedom.  The Lesser General
+Public License permits more lax criteria for linking other code with
+the library.
+
+  We call this license the "Lesser" General Public License because it
+does Less to protect the user's freedom than the ordinary General
+Public License.  It also provides other free software developers Less
+of an advantage over competing non-free programs.  These disadvantages
+are the reason we use the ordinary General Public License for many
+libraries.  However, the Lesser license provides advantages in certain
+special circumstances.
+
+  For example, on rare occasions, there may be a special need to
+encourage the widest possible use of a certain library, so that it becomes
+a de-facto standard.  To achieve this, non-free programs must be
+allowed to use the library.  A more frequent case is that a free
+library does the same job as widely used non-free libraries.  In this
+case, there is little to gain by limiting the free library to free
+software only, so we use the Lesser General Public License.
+
+  In other cases, permission to use a particular library in non-free
+programs enables a greater number of people to use a large body of
+free software.  For example, permission to use the GNU C Library in
+non-free programs enables many more people to use the whole GNU
+operating system, as well as its variant, the GNU/Linux operating
+system.
+
+  Although the Lesser General Public License is Less protective of the
+users' freedom, it does ensure that the user of a program that is
+linked with the Library has the freedom and the wherewithal to run
+that program using a modified version of the Library.
 
   The precise terms and conditions for copying, distribution and
 modification follow.  Pay close attention to the difference between a
 "work based on the library" and a "work that uses the library".  The
-former contains code derived from the library, while the latter only
-works together with the library.
-
-  Note that it is possible for a library to be covered by the ordinary
-General Public License rather than by this special one.
+former contains code derived from the library, whereas the latter must
+be combined with the library in order to run.
 

-		  GNU LIBRARY GENERAL PUBLIC LICENSE
+                  GNU LESSER GENERAL PUBLIC LICENSE
    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 
-  0. This License Agreement applies to any software library which
-contains a notice placed by the copyright holder or other authorized
-party saying it may be distributed under the terms of this Library
-General Public License (also called "this License").  Each licensee is
-addressed as "you".
+  0. This License Agreement applies to any software library or other
+program which contains a notice placed by the copyright holder or
+other authorized party saying it may be distributed under the terms of
+this Lesser General Public License (also called "this License").
+Each licensee is addressed as "you".
 
   A "library" means a collection of software functions and/or data
 prepared so as to be conveniently linked with application programs
@@ -617,7 +630,7 @@ distribute the object code for the work under the terms of Section 6.
 Any executables containing that work also fall under Section 6,
 whether or not they are linked directly with the Library itself.
 

-  6. As an exception to the Sections above, you may also compile or
+  6. As an exception to the Sections above, you may also combine or
 link a "work that uses the Library" with the Library to produce a
 work containing portions of the Library, and distribute that work
 under terms of your choice, provided that the terms permit
@@ -644,23 +657,31 @@ of these things:
     Library will not necessarily be able to recompile the application
     to use the modified definitions.)
 
-    b) Accompany the work with a written offer, valid for at
+    b) Use a suitable shared library mechanism for linking with the
+    Library.  A suitable mechanism is one that (1) uses at run time a
+    copy of the library already present on the user's computer system,
+    rather than copying library functions into the executable, and (2)
+    will operate properly with a modified version of the library, if
+    the user installs one, as long as the modified version is
+    interface-compatible with the version that the work was made with.
+
+    c) Accompany the work with a written offer, valid for at
     least three years, to give the same user the materials
     specified in Subsection 6a, above, for a charge no more
     than the cost of performing this distribution.
 
-    c) If distribution of the work is made by offering access to copy
+    d) If distribution of the work is made by offering access to copy
     from a designated place, offer equivalent access to copy the above
     specified materials from the same place.
 
-    d) Verify that the user has already received a copy of these
+    e) Verify that the user has already received a copy of these
     materials or that you have already sent this user a copy.
 
   For an executable, the required form of the "work that uses the
 Library" must include any data and utility programs needed for
 reproducing the executable from it.  However, as a special exception,
-the source code distributed need not include anything that is normally
-distributed (in either source or binary form) with the major
+the materials to be distributed need not include anything that is
+normally distributed (in either source or binary form) with the major
 components (compiler, kernel, and so on) of the operating system on
 which the executable runs, unless that component itself accompanies
 the executable.
@@ -709,7 +730,7 @@ Library), the recipient automatically receives a license from the
 original licensor to copy, distribute, link with or modify the Library
 subject to these terms and conditions.  You may not impose any further
 restrictions on the recipients' exercise of the rights granted herein.
-You are not responsible for enforcing compliance by third parties to
+You are not responsible for enforcing compliance by third parties with
 this License.
 

   11. If, as a consequence of a court judgment or allegation of patent
@@ -752,7 +773,7 @@ excluded.  In such case, this License incorporates the limitation as if
 written in the body of this License.
 
   13. The Free Software Foundation may publish revised and/or new
-versions of the Library General Public License from time to time.
+versions of the Lesser General Public License from time to time.
 Such new versions will be similar in spirit to the present version,
 but may differ in detail to address new problems or concerns.
 
@@ -773,7 +794,7 @@ decision will be guided by the two goals of preserving the free status
 of all derivatives of our free software and of promoting the sharing
 and reuse of software generally.
 
-			    NO WARRANTY
+                            NO WARRANTY
 
   15. BECAUSE THE LIBRARY IS LICENSED FREE OF CHARGE, THERE IS NO
 WARRANTY FOR THE LIBRARY, TO THE EXTENT PERMITTED BY APPLICABLE LAW.
@@ -796,7 +817,7 @@ FAILURE OF THE LIBRARY TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
 SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
 DAMAGES.
 
-		     END OF TERMS AND CONDITIONS
+                     END OF TERMS AND CONDITIONS
 

            How to Apply These Terms to Your New Libraries
 
@@ -815,18 +836,18 @@ convey the exclusion of warranty; and each file should have at least the
     Copyright (C) <year>  <name of author>
 
     This library is free software; you can redistribute it and/or
-    modify it under the terms of the GNU Library General Public
+    modify it under the terms of the GNU Lesser General Public
     License as published by the Free Software Foundation; either
-    version 2 of the License, or (at your option) any later version.
+    version 2.1 of the License, or (at your option) any later version.
 
     This library is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-    Library General Public License for more details.
+    Lesser General Public License for more details.
 
-    You should have received a copy of the GNU Library General Public
+    You should have received a copy of the GNU Lesser General Public
     License along with this library; if not, write to the Free Software
-    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 
 Also add information on how to contact you by electronic and paper mail.
 
-- 
2.0.0.526.g5318336


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
